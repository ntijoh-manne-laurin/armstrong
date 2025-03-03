require 'debug'

# En klass som hanterar routes och matchning med requests.
class Router

  # Skapar en ny router
  def initialize
    @routes = [] # [{method: "get", resource: "/banan", block: "..."}, {}]
  end

  # Sparar en route som ska användas av programmet senare.
  # 
  # @param method [String] Routens metod, "GET" eller "POST" etc.
  # @param resource [String] Routen som ska användas, använder regex för dynamiska routes.
  # @param block [String] Koden som routen ska returna, den html som ska skickas.
  def add_route(method, resource, &block)
    resource = Regexp.new(resource.gsub(/:\w+/, '(\w+)'))

    @routes += [{method: method, resource: resource, block: block}]
  end

  # Matchar en sparad route till en mottagen request, sedan körs blocket i routen.
  # 
  # @param request [Request] Den mottagna requesten.
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