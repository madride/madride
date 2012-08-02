module Madride
  describe Environment do
    include Rack::Test::Methods


    def app
      environment = Environment.new fixtures_root.to_s

      environment.append_path "assets"
      environment.append_path "pages"

      environment
    end


    it "should serve html" do
      get "/index.html"
      last_response.should be_ok
    end


    it "should serve javascript" do
      get "/app.js"
      last_response.should be_ok
    end


    it "should serve css" do
      get "/app.css"
      last_response.should be_ok
    end


    it "should respond with 404 if not found" do
      get "/foobar.html"
      last_response.should_not be_ok
    end


    it "should try serve index.html for directory if exists" do
      get "/about"
      last_response.should be_ok
      last_response.body.should match(%r{<title>\s*About\s*</title>})
    end


    it "should try serve directory as <dir>.html if such file exists" do
      get "/music"
      last_response.should be_ok
      last_response.body.should match(%r{<title>\s*Music\s*</title>})
    end


    it "should try serve /index.html for /" do
      get "/"
      last_response.should be_ok
      last_response.body.should match(%r{<title>\s*Madride Demo\s*</title>})
    end


    it "should set charset=utf8 for html files" do
      get "/"
      last_response.header['Content-Type'].should match(%r{charset=utf8$})
    end


    it "should keep Content-Type untouched for anything but html" do
      get "/app.js"
      last_response.header['Content-Type'].should_not match(%r{charset=utf8$})
    end
  end
end
