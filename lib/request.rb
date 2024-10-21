require_relative 'utils'

class Request
  
  attr_reader :method, :resource, :version, :headers

  def initialize(request_string)
    rows = request_string.split("\n")
    first_row, *rest = rows
    @method, @resource, @version = first_row.split(" ")
    # keys = header.map {|n| n.split(': ')[0]}
    # values = header.map {|n| n.split(': ')[1]}

    @headers = Utils.arr_to_hash(rest)
    
    # @headers = {|k,v| k.split}
  end
end