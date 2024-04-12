require_relative 'time_formatter'
class App
  TIME_FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%Hh',
    minute: '%Mm',
    second: '%Ss'
  }.freeze

  def call(env)
    @request = Rack::Request.new(env)
    @params = @request.params['format'].split(',')
    create_response
    [status, headers, body]
  end

  private

  def create_response
    return response(404, 'Wrong path') unless @request.path_info == '/time'

    @formatter = TimeFormatter.new(@params)
    @formatter.check_params
    return response(400, "Unknown time format #{@formatter.incorrect_params}") unless @formatter.success?

    response(200, @formatter.time)
  end

  def status
    @status_code
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    [@message]
  end

  def response(code, text)
    @status_code = code
    @message = text
  end
end
