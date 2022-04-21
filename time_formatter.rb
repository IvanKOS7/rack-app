class TimeFormatter

  FORMAT = { "year" => Time.now.year, "month" => Time.now.month, "day" => Time.now.day, "hour" => Time.now.hour, "minute" => Time.now.min, "sec" => Time.now.sec }.freeze

  attr_accessor :unknown_formats, :replace_arr

  def initialize(query_string)
    @query_string = query_string
    @unknown_formats = []
    @replace_arr = []
  end

  def call
    format_arr = @query_string.values[0].split(",")
    time_string(format_arr)
    if success?
      ["#{replace_arr.uniq.join("-")}"]
    else
      ["Unknown time format #{unknown_formats}"]
    end
  end

  def success?
    unknown_formats.empty?
  end

  private

  def strftime(item)
    FORMAT[item]
  end

  def time_string(arr)
    arr.each { |v| replace_arr.push(strftime(v)) && invalid_string(v) }
  end

  def invalid_string(item)
    unknown_formats.push(item)  unless FORMAT.include?(item)
  end

end
