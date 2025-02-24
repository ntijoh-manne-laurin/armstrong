require 'socket'
require_relative 'request'
require_relative 'response'
require_relative 'mime_types'

class HTTPServer

    def initialize(port)
        @port = port
    end

    # Startar och kör servern
    # 
    # @param router [Router] router-objektet med alla dess metoder.
    def start(router)
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        while session = server.accept
          data = ""
          while line = session.gets and line !~ /^\s*$/
              data += line
          end
          puts "RECEIVED REQUEST"
          puts "-" * 40
          puts data
          puts "-" * 40 
        

          request = Request.new(data)

          content = router.match_route(request)
          if content
            status  = 200
            content_type = "text/html"
          elsif File.exist?("public#{request.resource}") #Kolla om resursen (filen finns)
            status = 200
            #vad är det för typ av fil
            content_type = get_mime_from_file_name(request.resource)
            path = "public#{request.resource}"
            content = File.open(path, 'rb') {|file| file.read}
          else
            status = 404
            content = 'not found'
          end

          response = Response.new(status, content, session, content_type)
          response.send
        end
    end
end

