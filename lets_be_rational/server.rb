require 'socket'
require 'json'

def random_fraction
  fraction = { :num => rand(1000) + 1, :den => rand(1000) + 1 }
  JSON.generate(fraction).to_s
end

server = TCPServer.new('localhost', 8080)

loop do
  socket = server.accept
  request = socket.gets
  response = random_fraction + "\n"

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"

  socket.print "\r\n"
  socket.print response
  socket.close
end
