module Madride
  describe Server do
    include Rack::Test::Methods


    def app
      env = Environment.new fixtures_root.to_s
      env.append_path '.'
      Server.new(env).app
    end


    it "should serve html" do
      get "/hello.html"
      last_response.should be_ok
    end

    it "should serve js" do
      get "/foo.js"
      last_response.should be_ok
    end


    it "should respond with 404 if not found" do
      get "/moo.html"
      last_response.should_not be_ok
    end
  end
end
