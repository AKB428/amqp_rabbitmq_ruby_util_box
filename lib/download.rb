require 'uri'
require 'httpclient'
require 'pathname'

def download(url, opt)

  http_client = HTTPClient.new
  header = nil
  query = nil

  dest_file = File.join('./', File.basename(url))
  if opt.has_key?('dest_folder')
    dest_file = File.join(opt['dest_folder'], File.basename(url))
    FileUtils.mkdir_p(opt['dest_folder']) unless File.exist?(opt['dest_folder'])
  end

  http_client.receive_timeout = 60 * 10
  if opt.has_key?('receive_timeout')
    http_client.receive_timeout = opt['receive_timeout']
  end

  open(dest_file, 'wb') do |file|
    http_client.get_content(URI.parse(URI.encode(url)), query, header) do |chunk|
      file.write chunk
    end

  end
  dest_file
end