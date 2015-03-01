require "bunny"
require './lib/download.rb'

conn = Bunny.new
conn.start

ch   = conn.create_channel
q    = ch.queue("development.dwonload_url")

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"

while(true) do
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"

    body_list = body.split(' ')
    url = body_list[0]
    opt = {
        'dest_folder' => body_list[1]
    }

    puts url
    p opt

    download_path = download(url, opt)

    puts " [x] Download #{download_path}"

  end
end