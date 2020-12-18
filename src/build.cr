require "benchmark"
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

    def files()
      Dir.glob File.join(@input, "*")
    end

    def execute()
      ms = Benchmark.realtime {
        files.each {|asset|
          @manifest.add_asset(build: self, asset: asset)
        }

        File.write(File.join(@output, "manifest.json"), 
          @manifest.to_json)
      }

      puts "built %s assets in %s" % [
        @manifest.available.size,
        ms]
    end
  end
end