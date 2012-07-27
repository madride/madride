module Madride
  describe Environment do
    include Rack::Test::Methods


    def environment
      environment = Environment.new fixtures_root.to_s

      environment.append_path "assets"
      environment.append_path "pages"

      environment
    end


    it "should process html" do
      asset = environment["index.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{<title>\s*Madride Demo\s*</title>})
    end


    it "should accept locals data" do
      env = environment
      env.data = YAML.load_file fixtures_path.join('data.yml').to_s

      asset = env["index.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{pennywise})
    end


    it "should allow propose +global+ paths" do
      Environment.append_path "foobar"
      environment.paths.should.include? "foobar"
    end
  end
end
