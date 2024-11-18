class Router
  def initialize
    @routes = [] # [{method: "get", resource: "/banan", block: "..."}, {}]
  end

# GET /grillkorv
# GET /grillkorv/3

  def add_route(method, resource, &block)
    p method
    p resource
    p block
    @routes += [{method: method, resource: resource, block: block}]
  end

  def match_route(request)
    p @routes
    route = @routes.find {|route| (route[:method] == request.method && route[:resource] == request.resource)}
    route[:block].call
  end
end




# add_route("/banan/") do 
#   return "<h1>Welcome</h1>"
# end