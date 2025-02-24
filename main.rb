require_relative 'lib/router'
require 'erb'
require_relative "lib/tcp_server"

server = HTTPServer.new(4567)
router = Router.new

# Skapar ett nytt erb-objekt och läser av en erb-fil
# 
# @param file_path [String] sökvägen till erb-filen
# @return [String] Den filtrerade datan som ska användas.
def erb(file_path)
  ERB.new(File.read(file_path)).result(binding)
end

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


server.start(router)