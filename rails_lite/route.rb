class Route

  def initialize(req)
    @url_pattern = req.path
    @http_method = req.request_method.downcase
    @controller = controller
    @action = action
  end

  def matches?(req)

  end

  def method_matches?(req.)

end

