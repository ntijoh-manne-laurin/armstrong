class Request
  
  attr_reader :method, :resource, :version, :headers

  def initialize(request_string)
    rows = request_string.split("\n")
    first_row, *header = rows
    @method, @resource, @version = first_row.split(" ")
    @headers = {'Host' => 'developer.mozilla.org'}
  end
end