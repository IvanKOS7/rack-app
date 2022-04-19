class AppTime

  FORMAT = ["year", "month", "day", "hour", "minute", "second"]

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    time_checker(env['QUERY_STRING'])
    if env['REQUEST_PATH'] == "/time" && true_format?(@format_arr)
      replace(@format_arr)
      body = ["#{@replace_arr.uniq.join("-")}"]
      [status, headers, body]
    else
      unknown_format(@format_arr)
      status = 404
      body = ["Unknown time format #{@unknown_formats}"]
      [status, headers, body]
    end
  end

  private

  def time_checker(query_string)
    input_format = Rack::Utils.parse_query(query_string)
    @format_arr = input_format.values[0].split(",")
  end

  def unknown_format(arr)
    @unknown_formats = []
    arr.each do |v|
      unless FORMAT.include?(v)
        @unknown_formats.push(v)
      end
    end
  end

  def replace(arr)
    @replace_arr = []
    time = Time.now
    arr.each do |v|
      @replace_arr.push(time.send "#{v}")
    end
  end

  def true_format?(arr)
    arr.all? {|v| FORMAT.include?(v)}
  end

end
