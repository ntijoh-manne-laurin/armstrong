class Response
  attr_reader :status, :body, :session, :content_type

  def initialize(status, body, session, content_type)
    @status = status
    @body = body
    @session = session
    @content_type = content_type
  end

  def send
    @session.print "HTTP/1.1 #{@status}\r\n"
    @session.print "Content-length: #{@body.length}\r\n"
    @session.print "Content-Type: #{@content_type}\r\n\r\n#{@body}"
    @session.close
  end

end