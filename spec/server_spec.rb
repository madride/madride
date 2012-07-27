module Madride
  class Environment
    describe "Server Application" do
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


      it "should show list files when directory has no index" do
        get "/music"
        last_response.should be_ok
        last_response.body.should match(/bands[.]html/)
      end


      it "should should fallback to index.html if directory requested" do
        get "/"
        last_response.should be_ok
        last_response.body.chould match(/Madride Demo/)
      end
    end
  end
end
