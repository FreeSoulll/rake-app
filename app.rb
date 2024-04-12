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
    data
    [status, headers, body]
  end

  private

  def data
    @status_code = 200
    @message = 'dsds'

    return wrong_path unless @request.path_info == '/time'

    check_params
    return unknown_format unless @incorrect_params.empty?

    formed_time
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

  def wrong_path
    @status_code = 404
    @message = 'Wrong path'
  end

  def unknown_format
    @status_code = 400
    @message = "Unknown time format #{@incorrect_params}"
  end

  def check_params
    @correct_params, @incorrect_params = @params.partition { |key| TIME_FORMATS.key?(key.to_sym) }

    puts("corret - #{@correct_params}")
    puts("incorret - #{@incorrect_params}")
  end

  def time
    formats = @correct_params.map { |format| TIME_FORMATS[format.to_sym] }
    Time.now.strftime(formats.join('-'))
  end

  def formed_time
    @status_code = 200
    @message = time
  end
end
