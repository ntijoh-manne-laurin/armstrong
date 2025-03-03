# En klass för att hantera svar till webbläsaren
class Response
  attr_reader :status, :body, :session, :content_type

  # Initierar Response-objektet
  # 
  # @param status [Integer] Status, 404, 200 etc.
  # @param body [String] Den data som ska skickas.
  # @param session []
  def initialize(status, body, session, content_type)
    @status = status
    @body = body
    @session = session
    @content_type = content_type
  end

  # Skickar datan till webbläsaren.
  def send
    @session.print "HTTP/1.1 #{@status}\r\n"
    @session.print "Content-length: #{@body.length}\r\n"
    @session.print "Content-Type: #{@content_type}\r\n"
    @session.print "\r\n"
    @session.print @body
    @session.close
  end

end