require 'debug'

class Router
  def initialize
    @routes = [] # [{method: "get", resource: "/banan", block: "..."}, {}]
  end

# GET /grillkorv
# GET /grillkorv/3

  def add_route(method, resource, &block)
    resource = Regexp.new(resource.gsub(/:\w+/, '(\w+)'))

    @routes += [{method: method, resource: resource, block: block}]
  end

  def match_route(request)
    matched_route = @routes.find {|route| route[:method] == request.method && route[:resource].match?(request.resource)}

    if matched_route == nil
      return nil
    else
      match = matched_route[:resource].match(request.resource)
  
      matched_route[:block].call(*match.captures)
    end
  end
end




# add_route("/banan/") do 
#   return "<h1>Welcome</h1>"
# end