require 'debug'

class Router
  def initialize
    @routes = [] # [{method: "get", resource: "/banan", block: "..."}, {}]
  end

# GET /grillkorv
# GET /grillkorv/3

  def add_route(method, resource, &block)
    @routes += [{method: method, resource: resource, block: block}]
  end

  def match_route(request)
    @routes.each do |route|
      if route[:resource].include?(":")
        params = []
        resource = route[:resource].split("/")
        resource.each do |param| 
          if param.include?(":") 
            binding.break
            params << param
          end
        end

        resource_string = ""
        route[:resource].each do |element|
          if element == ":"
            break
          end
          resource_string << element
        end

        i = 0
        while route[:resource][i] != ":"
          if route[:resource][i] == request[i]
        end

        if route[:method] == request.method
          route = route
          break
        end

      else
        if route[:method] == request.method && route[:resource] == request.resource
          route = route
          break
        end
      end
    end

    if route == nil
      return nil
    else
      require 'debug'
      binding.break
      route[:block].call(params)
    end
  end
end




# add_route("/banan/") do 
#   return "<h1>Welcome</h1>"
# end