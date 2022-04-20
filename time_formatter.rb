class TimeFormatter

  FORMAT = ["year", "month", "day", "hour", "min", "sec"].freeze

  attr_accessor :body, :unknown_formats, :replace_arr

  def initialize(query_string)
    @query_string = query_string
    @unknown_formats = []
    @replace_arr = []
    @body = body
    time_checker(query_string)
  end

  private

  def time_checker(query_string)
    @format_arr = query_string.values[0].split(",")
    format_method(@format_arr)
    if true_format?(@format_arr)
      self.body = ["#{self.replace_arr.uniq.join("-")}"]
    else
      self.body = ["Unknown time format #{self.unknown_formats}"]
    end
  end

  def true_format?(arr)
    arr.all? {|v| FORMAT.include?(v)}
  end

  def format_method(format_arr)
    time = Time.now
    format_arr.each do |v|
      unless FORMAT.include?(v)
        @unknown_formats.push(v)
      else
        @replace_arr.push(time.send "#{v}")
      end
    end
  end
end
