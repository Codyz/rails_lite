require 'json'
require_relative './cookies.rb'
require 'active_support/core_ext'


class ControllerBase

  attr_accessor :req, :res, :session

  def initialize(req, res)
    @req = req
    @res = res
    @response_built = false
  end

  def render_content(content, body_type)
    unless @response_built
      @response_built = true
      @res.content_type = body_type
      self.session["content_type"] = body_type
      @res.body = content
      self.session["body"] = content
      self.session.store_session(@res)
    end
  end

  def redirect_to(url)
    unless @response_built
      @response_built = true
      @res.status = 302
      @res.header["Location"] = url
      self.session.store_session(@res)
    end
  end

  def session
    if @response_built == true
      @session
    else
      @session = Session.new(@req)
    end
  end

  def render(view)
    folder = self.class.to_s.underscore.gsub!("_controller", "")
    final_path = "views/#{folder}/#{view}.html.erb"
    read_view = File.read(final_path)
    template = ERB.new(read_view).result(binding)
    p template
    render_content(template, "text/html")
  end

end