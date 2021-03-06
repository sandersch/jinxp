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

    pp build_2

    build_2.manifest.available.size.should eq 2
    noop = build_2.manifest.available.find {|asset|
      asset.file.includes?("noop.lic")
    }
    fail "noop.lic did not compile" unless noop
    noop.tags.size.should eq 3
  end
end

