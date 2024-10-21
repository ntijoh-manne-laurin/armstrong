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


end