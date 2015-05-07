queue = %w[生 麦 生 米 生 卵]

server = SimpleHttpServer.new(
  server_ip:     "0.0.0.0",
  port:          ARGV[0],
  document_root: "./",
)

server.location "/" do |r|
  content = ""

  while rand > 0.1 do
    char = queue.shift
    content << char
    queue.push(char)
  end

  server.response_body = "#{content}\n"
  server.create_response
end

server.run
