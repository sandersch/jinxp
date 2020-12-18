require "./asset"
require "json"

module Jinx
  class Manifest
    include JSON::Serializable
    property available    : Array(Asset)
    property last_updated : Int64
    
    def initialize()
      @available = [] of Asset
      @last_updated = Time.utc.to_unix
    end

    def add_asset(build, asset)
      @available << Asset.new(build, asset)
    end
  end
end