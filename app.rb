class App
  require 'rack'
  require_relative 'time_formatter'

  def call(env)
    @env = env
    @input_format = Rack::Utils.parse_query(@env['QUERY_STRING'])
    @time_formatter = TimeFormatter.new(@input_format)
    [status, headers, body]
  end

  private

  def status
    @time_formatter.unknown_formats.empty? ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain; charset=utf-8'}
  end

  def body
    [@time_formatter.body.to_s]
  end
end
