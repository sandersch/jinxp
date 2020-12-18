require "./spec_helper"

describe Jinx::Manifest do
  it "Manifest.new" do
    m = Jinx::Manifest.new
    pp m.to_json
  end
end
