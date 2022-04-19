class App
  require 'rack'

  def call(env)
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain; charset=utf-8',
      'format' => 'json',
    'fevev' => 'cc'}
  end

  def body
    ['hi']
  end
end
