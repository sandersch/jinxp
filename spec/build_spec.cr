require "./spec_helper"

describe Jinx::Build do
  it "Build.new()" do
    expect_raises(Exception, /in\/ is not a dir/) { 
      Jinx::Build.new(input: "in/") 
    }

    build_2 = Jinx::Build.new(
      input: File.join(__DIR__, "repo"))

    build_1 = Jinx::Build.new(
      input: File.join(__DIR__, "repo"), 
      output: Dir.tempdir)

    build_2.execute()

    pp build_2.manifest.to_json
  end
end

