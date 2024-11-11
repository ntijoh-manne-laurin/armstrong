require_relative 'spec_helper'
require_relative '../lib/request'

describe 'Request' do

	describe 'Simple get-request' do

		it 'parses the http method' do
			request_string = File.read('./test/example_requests/get-index.request.txt')
			request = Request.new(request_string)
			_(request.method).must_equal "GET"
		end
		it 'parses the resource' do
			request_string = File.read('./test/example_requests/get-index.request.txt')
			request = Request.new(request_string)
			_(request.resource).must_equal "/"
		end
		it 'parses the version' do
			request_string = File.read('./test/example_requests/get-index.request.txt')
			request = Request.new(request_string)
			_(request.version).must_equal "HTTP/1.1"
		end
		it 'parses the headers' do
			request_string = File.read('./test/example_requests/get-index.request.txt')
			request = Request.new(request_string)
			headers =  {'Host' => 'developer.mozilla.org', 'Accept-Language' => 'fr'}
			_(request.headers).must_equal headers
		end
	end
	describe 'Get-request with more headers' do

		it 'parses the http method' do
			request_string = File.read('./test/example_requests/get-examples.request.txt')
			request = Request.new(request_string)
			_(request.method).must_equal "GET"
		end

		it 'parses the resource' do
			request_string = File.read('./test/example_requests/get-examples.request.txt')
			request = Request.new(request_string)
			_(request.resource).must_equal "/examples"
		end

		it 'parses the version' do
			request_string = File.read('./test/example_requests/get-examples.request.txt')
			request = Request.new(request_string)
			_(request.version).must_equal "HTTP/1.1"
		end

		it 'parses the headers' do
			request_string = File.read('./test/example_requests/get-examples.request.txt')
			request = Request.new(request_string)
			headers =  {'Host' => 'example.com', 'User-Agent' => 'ExampleBrowser/1.0', 'Accept-Encoding' => 'gzip, deflate', 'Accept' => '*/*'}
			_(request.headers).must_equal headers
		end
	end

	describe 'Get-request with parameters' do 
		
		it 'parses the http method' do
			request_string = File.read('./test/example_requests/get-fruits-with-filter.request.txt')
			request = Request.new(request_string)
			_(request.method).must_equal "GET"
		end

		it 'parses the resource' do
			request_string = File.read('./test/example_requests/get-fruits-with-filter.request.txt')
			request = Request.new(request_string)
			_(request.resource).must_equal "/fruits?type=bananas&minrating=4"
		end

		it 'parses the version' do
			request_string = File.read('./test/example_requests/get-fruits-with-filter.request.txt')
			request = Request.new(request_string)
			_(request.version).must_equal "HTTP/1.1"
		end

		it 'parses the headers' do
			request_string = File.read('./test/example_requests/get-fruits-with-filter.request.txt')
			request = Request.new(request_string)
			headers =  {'Host' => 'fruits.com', 'User-Agent' => 'ExampleBrowser/1.0', 'Accept-Encoding' => 'gzip, deflate', 'Accept' => '*/*'}
			_(request.headers).must_equal headers
		end

		it 'parses the parameters' do
			request_string = File.read('./test/example_requests/get-fruits-with-filter.request.txt')
			request = Request.new(request_string)
			params = {'type' => 'bananas', 'minrating' => '4'}
			_(request.params).must_equal params
		end
	end

	describe 'Post-request' do
		it 'parses the http method' do
			request_string = File.read('./test/example_requests/post-login.request.txt')
			request = Request.new(request_string)
			_(request.method).must_equal "POST"
		end

		it 'parses the resource' do
			request_string = File.read('./test/example_requests/post-login.request.txt')
			request = Request.new(request_string)
			_(request.resource).must_equal "/login"
		end

		it 'parses the version' do
			request_string = File.read('./test/example_requests/post-login.request.txt')
			request = Request.new(request_string)
			_(request.version).must_equal "HTTP/1.1"
		end

		it 'parses the headers' do
			request_string = File.read('./test/example_requests/post-login.request.txt')
			request = Request.new(request_string)
			headers =  {'Host' => 'foo.example', 'Content-Type' => 'application/x-www-form-urlencoded', 'Content-Length' => '39'}
			_(request.headers).must_equal headers
		end

		it 'parses the parameters' do
			request_string = File.read('./test/example_requests/post-login.request.txt')
			request = Request.new(request_string)
			params = {'username' => 'grillkorv', 'password' => 'verys3cret!'}
			_(request.params).must_equal params
		end
	end
	

end