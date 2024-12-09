require 'socket'
require_relative 'request'
require_relative 'router'
require_relative 'response'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"
        router = Router.new
        router.add_route("GET","/banan") do
          "<h1> Hello, banan </h1>"
        end
        

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
          
          html = router.match_route(request)
          if html != nil
            status  = 200
          elsif File.exist?("/public/#{request.resource}") #Sen kolla om resursen (filen finns)
            #vad är det för typ av fil
            
          else
            #404
            html = 'not found'
            status = 404
          end

          response = Response.new(status, html, session)
          response.send
          #session.print response.to_s
          #session.close
        end
    end
end

