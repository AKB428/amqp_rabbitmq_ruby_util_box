require "bunny"

if (ARGV.nil? || ARGV.size < 2)
  puts "need argument length 2. ARGV[0]=NAME ARGV[1]=BODY"
  exit -1
end

namespace = ARGV[0]
body = ARGV[1]

conn = Bunny.new
conn.start

ch   = conn.create_channel

q    = ch.queue(namespace)
ch.default_exchange.publish(body, :routing_key => q.name)
puts " [x] Send #{body}"

conn.close