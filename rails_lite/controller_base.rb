class ControllerBase

  def initialize(req, res)
    @req = req
    @res = res
    @response_built = false
  end

  def render_content(content, body_type)
    unless @response_built
      @res.content_type = body_type
      @res.body = content
      @response_built = true
    end
  end

  def redirect_to(url)
    unless @response_built
      @res.status = 302
      @res.header["Location"] = url
      @response_built = true
    end
  end

end