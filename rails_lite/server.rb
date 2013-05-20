# require 'active_support/core_ext'
require 'webrick'
# require 'rails_lite'
require_relative './controller_base.rb'
require_relative './cookies.rb'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
root = '/'
server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }




class MyController < ControllerBase

  def go
    if @req.path == "/redirect"
      redirect_to("http://google.com")
    elsif @req.path == "/render"
      render_content(@req.query["content"], "text/text")
    end
    # render_content("hello world!", "text/html")

    # after you have sessions going, uncomment:
#    session["count"] ||= 0
#    session["count"] += 1
#    render_content("#{session["count"]}", "text/html")

    # after you have template rendering
#    render :show
  end

end


server.mount_proc '/' do |req, res|
  # res.content_type = "text/text"
  # res.body = req.path
   MyController.new(req, res).go
end

server.start




# Write a file, lib/rails_lite/server.rb. Create a new WEBrick::HTTPServer on port 8080. To write your own custom handling of web requests, tell the server to use a proc to serve responses. Use HTTPServer#mount_proc. You give it a root URL and a proc which will be passed the HTTPRequest as well a HTTPResponse to fill out.
#
# To start, set the root URL to '/'. Set the HTTPResponse#content_type to text/text (also called the mime type) and the body to the HTTPRequest#path.
#
# Hint: WEBrick doesn't like to shut down cleanly. Add this line before you start the server: