require "./header_parser"
require "./manifest"
require "./build"
# TODO: Write documentation for `Jinx`
module Jinx
  VERSION = "0.1.0"

  #FileUtils.mkdir_p("dist/assets")
  #FileUtils.mkdir_p("dist/headers")
  #manifest = {available: [], last_updated: Time.now.to_i}
  #Log.out("creating jinx manifest", label: %i(jinx info))
  #File.write("dist/manifest.json", 
  #  JSON.pretty_generate(manifest))

  def build(input : String, output : String)
    Build.new(input:  File.join(Dir.current, input),
              output: File.join(Dir.current, output))
  end
end
