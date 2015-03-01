require 'json'
require 'optparse'
require 'rabbit_swift'
require "bunny"

opt = OptionParser.new
Version = '1.0.0'

swift_conf_json = nil
conf_path = './config/conf.json'
opt.on('-c CONF_PATH', 'conf_path') {|v| conf_path = v}
opt.parse!(ARGV)

File.open conf_path do |file|
  conf = JSON.load(file.read)
  swift_conf_json = conf['swift']
end

conn = Bunny.new
conn.start

ch   = conn.create_channel
q    = ch.queue("development.send_object_strage")

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"

rabbit_swift_client = RabbitSwift::Client.new(swift_conf_json);
token = rabbit_swift_client.get_token
puts 'token -> ' + token

while(true) do
  q.subscribe(:block => true) do |delivery_info, properties, body|
    body_hash = JSON.load(body)
    dest_path = body_hash['dest_path']
    src_path = body_hash['src_path']

    puts dest_path
    puts src_path

    status = nil
    flag = 0
    begin
      status = rabbit_swift_client.upload(token, swift_conf_json['endPoint'] + dest_path, src_path)
    rescue => ex
      flag += 1
      puts ex.message
      # TODO 一度だけトークンを取得し直す、トークンリフレッシュの暫定コード
      token = rabbit_swift_client.get_token
      if flag < 2
        retry
      end
    end

    puts 'http_status -> ' + status.to_s
    if (status == RabbitSwift::Client::UPLOAD_SUCCESS_HTTP_STATUS_CODE)
      puts 'upload OK'
    else
      puts 'upload fail! ><'
      # TODO 一度だけトークンを取得し直す、トークンリフレッシュの暫定コード
      token = rabbit_swift_client.get_token
      rabbit_swift_client.upload(token, swift_conf_json['endPoint'] + dest_path, src_path)
    end

  end
end

# cancel the consumer to exit
# delivery_info.consumer.cancel

