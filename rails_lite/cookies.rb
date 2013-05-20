require 'json'
require 'webrick'

class Session

  attr_accessor :session_cookie

  def initialize(request)  # see later if we need this

    oreo = request.cookies.detect {|cookie| cookie.name == "_rails_lite_app"}
    if oreo
      @session_cookie = JSON.parse(oreo.value)
    else
      @session_cookie = {}
      request.cookies << WEBrick::Cookie.new("_rails_lite_app", @session_cookie.to_json)
    end
    @session_cookie
  end

  def [](key)
    @session_cookie[key]
  end

  def []=(key, value)
    @session_cookie[key] = value
  end

  def store_session(response)
    response.cookies << WEBrick::Cookie.new("_rails_lite_app", @session_cookie.to_json)
  end

end
