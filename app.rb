require 'rack'
require_relative 'time_formatter'

class App

  def call(env)
    input_format = Rack::Utils.parse_query(env['QUERY_STRING'])
    t = TimeFormatter.new(input_format)
    response(t.call, status(t), headers)
  end

  private

  def response(body, status, headers)
    r = Rack::Response.new(body, status, headers)
    r.finish
  end

  def status(obj)
    obj.success? ? 200 : 404
  end

  def headers
    { 'Content-Type' => 'text/plain; charset=utf-8' }
  end

end
