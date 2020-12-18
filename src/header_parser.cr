module Jinx
  class HeaderParser
    HEADER_PATTERN = /^=begin\r?\n?(.+?)^=end/m

    def self.parse_headers(source)
      source.match(HEADER_PATTERN) ? $1 : nil
    end

    def self.parse_tags(header : Nil)
      [] of String
    end

    def self.parse_tags(header : String)
      parse_tags(nil)
    end

    property header : String?
    property tags   : Array(String)
    property file   : String?

    def initialize(build : Build, file : String, @source : String)
      @header = HeaderParser.parse_headers(@source)
      @tags   = HeaderParser.parse_tags(@header)
      @file   = write(build, file)
    end

    def write(build, file)
      return nil if @header.nil?
      basename = File.basename(file)
      header_file = "%s.header" % basename.split(".").last
      File.write(File.join(build.headers, basename), @header)
      "/headers/%s" % header_file
    end
  end
end