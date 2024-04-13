class TimeFormatter
  TIME_FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%Hh',
    minute: '%Mm',
    second: '%Ss'
  }.freeze

  def initialize(params)
    @params = params
  end

  def check_params_and_get_time
    correct_formats = []
    incorrect_formats = []

    @params.each do |key|
      if TIME_FORMATS.key?(key.to_sym)
        correct_formats << TIME_FORMATS[key.to_sym]
      else
        incorrect_formats << key
      end
    end

    if incorrect_formats.empty?
      time = Time.now.strftime(correct_formats.join('-'))
      { success: true, time: time }
    else
      { success: false, incorrect_params: incorrect_formats }
    end
  end
end
