# frozen_string_literal: true


# En klass för att hantera requests på ett mer effektivt sätt.
class Request
  attr_reader :method, :resource, :version, :headers, :params

  def find_params(params)
    if @method == 'GET'
      _, param_string = @resource.split('?')
    elsif @method == 'POST'
      param_string = params
    end
    return nil if param_string.nil?


    param_string.split('&').map { |set| set.split('=') }.to_h
  end

  # Sorterar mottagen data och skapar ett nytt request-objekt.
  #
  # @param request_string [String] Den mottagna datan.
  def initialize(request_string)
    body, params = request_string.split("\n\n")
    rows = body.split("\n")
    first_row, *rest = rows
    @method, @resource, @version = first_row.split(' ')
    @headers = rest.map { |lines| lines.split(': ', 2) }.to_h
    @params = find_params(params)
  end
end
