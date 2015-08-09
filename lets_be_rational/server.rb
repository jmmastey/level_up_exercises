require 'socket'
require 'json'

def random_fraction
  fraction = { num: rand(1000) + 1, den: rand(1000) + 1 }
  JSON.generate(fraction).to_s
end

def header(size)
  ["HTTP/1.1 200 OK",
   "Content-Type: text/plain",
   "Content-Length: #{size}",
   "Connection: close\r\n"].join("\r\n")
end

server = TCPServer.new('localhost', 8080)

loop do
  socket = server.accept
  socket.gets
  response = random_fraction + "\n"

  socket.print header(response.size)
  socket.print "\r\n"
  socket.print response
  socket.close
end
