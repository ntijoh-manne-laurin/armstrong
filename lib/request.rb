require_relative 'utils'

class Request
	
	attr_reader :method, :resource, :version, :headers, :params

	def find_params
		if @method == 'GET'
			_, param_string = @resource.split('?')
			if param_string == nil
				return nil
			else
				param_string.split('&').map{|set| set.split('=')}.to_h
			end
		end
	end

	def initialize(request_string)
		rows = request_string.split("\n")
		first_row, *rest = rows
		@method, @resource, @version = first_row.split(" ")
		@headers = rest.map{|e| e.split(": ", 2)}.to_h
		@params = find_params
	end
end