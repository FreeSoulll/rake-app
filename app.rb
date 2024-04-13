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
    request = Rack::Request.new(env)
    params = request.params['format'].split(',')
    create_response(params, request)
  end

  private

  def create_response(params, request)
    return response(404, headers, 'Wrong path') unless request.path_info == '/time'

    formatter = TimeFormatter.new(params).check_params_and_get_time
    return response(400, headers, "Unknown time format #{formatter[:incorrect_params]}") unless formatter[:success]

    response(200, headers, formatter[:time])
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(code, headers, text)
    [code, headers, [text]]
  end
end
