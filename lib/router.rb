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
        resource = route[:resource].split("/")
        resource.each {|p| p.include?(":") params << p}
      end
    end

    route = @routes.find {|route| (route[:method] == request.method && route[:resource] == request.resource)}
    if route == nil
      return nil
    else
      require 'debug'
      binding.break
      route[:block].call
    end
  end
end




# add_route("/banan/") do 
#   return "<h1>Welcome</h1>"
# end