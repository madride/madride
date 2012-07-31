module Madride
  describe Environment do
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
      env.locals.merge! YAML.load_file fixtures_path('data.yml').to_s

      asset = env["music/bands.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{pennywise})
    end


    it "should allow add +global+ paths relative to environment root" do
      Madride.append_path "/foo"
      Madride.append_path "bar"

      environment = Environment.new "/"
      environment.paths.should include "/foo"
      environment.paths.should include "/bar"

      environment = Environment.new fixtures_root.to_s
      environment.paths.should include "/foo"
      environment.paths.should include fixtures_path('bar').to_s
    end


    it "should allow omit .html prefix extension" do
      asset = environment["simple.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{<title>\s*Simple Page\s*</title>})
    end


    it "should use default layout if layouts path provided" do
      env = environment
      env.add_layouts_path "layouts"

      asset = env["videos/index.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{<title>\s*Default Layout\s*</title>})
    end


    it "should allow set per-file layout using +layout+ directive" do
      env = environment
      env.add_layouts_path "layouts"

      asset = env["videos/extended.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{<title>\s*Extended Layout\s*</title>})
    end


    it "should respect +disable_layout+ directive" do
      env = environment
      env.add_layouts_path "layouts"

      asset = env["videos/hardcore.html"]
      asset.should_not be_nil
      asset.to_s.should match(%r{<title>\s*No Layout\s*</title>})
    end
  end
end
