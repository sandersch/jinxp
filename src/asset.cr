require "digest/sha1"
require "json"
require "./header_parser"

module Jinx
  class Asset
    include JSON::Serializable

    property header      : String?
    property md5         : String
    property last_commit : String
    property tags        : Array(String)
    property file        : String

    def initialize(build : Build, file : String)
      source       = File.read(file)
      @md5         = Digest::SHA1.base64digest(source)
      @last_commit = _fetch_last_commit(file)
      @file        = "/assets/%s" % File.basename(file)

      parser  = HeaderParser.new(
        build:  build, 
        file:   file, 
        source: source)
      @tags   = parser.tags
      @header = parser.file
    end

    def _fetch_last_commit(file)
      `git log -1 --date=unix --format="%ad" -- #{file}`
    end
  end
end