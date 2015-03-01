require "bunny"

conn = Bunny.new
conn.start

ch   = conn.create_channel
q    = ch.queue("development.dwonload_url")

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"

while(true) do
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"

    # cancel the consumer to exit
    delivery_info.consumer.cancel
  end
end