class TimeFormatter
  TIME_FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%Hh',
    minute: '%Mm',
    second: '%Ss'
  }.freeze

  attr_reader :incorrect_params

  def initialize(params)
    @params = params
  end

  def check_params
    @correct_params, @incorrect_params = @params.partition { |key| TIME_FORMATS.key?(key.to_sym) }
  end

  def success?
    @incorrect_params.empty?
  end

  def time
    formats = @correct_params.map { |format| TIME_FORMATS[format.to_sym] }
    Time.now.strftime(formats.join('-'))
  end
end
