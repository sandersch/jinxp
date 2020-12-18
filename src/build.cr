require "./manifest"

module Jinx
  class Build
    property assets   : String
    property headers  : String
    property manifest : Manifest

    def initialize(@input : String, @output = File.join(Dir.current, "dist"))
      @assets   = File.join(@output, "assets")
      @headers  = File.join(@output, "headers")
      @manifest = Manifest.new()

      [@assets, @headers].each {|build_dir|
        Dir.mkdir_p(build_dir)
      }

      [@input, @output, @assets, @headers].each {|dir|
        raise Exception.new("%s is not a directory" % dir) unless Dir.exists?(dir)
      }
    end

    def assets()
      Dir.glob File.join(@input, "*")
    end

    def execute()
      assets.each {|asset|
        @manifest.add_asset(build: self, asset: asset)
      }
    end
  end
end