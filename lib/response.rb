class Response
  attr_reader :status, :body, :session

  def initialize(status, body, session)
    @status = status
    @body = body
    @session = session
  end
  def to_s
    return "HTTP/1.1 #{@status}\r\nContent-length: #{@body.length}\r\nContent-Type: text/html\r\n\r\n#{@body}"
  end

  def send
    @session.print "HTTP/1.1 #{@status}\r\n"
    @session.print "Content-length: #{@body.length}\r\n"
    @session.print "Content-Type: text/html\r\n\r\n#{@body}"
    @session.close
  end

end