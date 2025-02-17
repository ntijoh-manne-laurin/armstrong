require 'socket'
require_relative 'request'
require_relative 'router'
require_relative 'response'
require_relative 'mime_types'
require 'erb'

class HTTPServer

    def initialize(port)
        @port = port
    end

    # Skapar ett nytt erb-objekt och läser av en erb-fil
    # 
    # @param file_path [String] sökvägen till erb-filen
    # @return [String] Den filtrerade datan som ska användas.
    def erb(file_path)
      ERB.new(File.read(file_path)).result(binding)
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"
        router = Router.new

        router.add_route("GET","/banan/:id") do |id|
          @id = id
          erb('views/banan_id.erb')
        end

        router.add_route("GET","/banan") do
          erb('views/banan.erb')
        end

        router.add_route("GET","/plus-fem/:num") do |num|
          @result = num.to_f + 5
          @num = num
          erb('views/plus_fem.erb')
        end

        router.add_route("GET","/addera/:num1/:num2") do |num1, num2|
          @num1 = num1.to_f
          @num2 = num2.to_f
          erb('views/addera.erb')
        end

        router.add_route("GET", "/dice/:num") do |num|
          @num = num.to_i
          erb('views/dice.erb')
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

