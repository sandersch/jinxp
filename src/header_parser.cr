module Jinx
  class HeaderParser
    HEADER_PATTERN  = /^=begin\r?\n?(.+?)^=end/m
    TAGS_PATTERN    = /^[\s\t#]*tags: (.*?)$/i
    VERSION_PATTERN = /^[\s\t#]*version: (.*)$/i
    AUTHOR_PATTERN = /^[\s\t#]*author: (.*)$/i

    def self.parse_headers(source)
      source.match(HEADER_PATTERN) ? $1 : nil
    end

    def self.parse_tags(header : Nil)
      [] of String
    end

    def self.parse_tags(header : String)
      tags = header.lines.find {|line| line.match(TAGS_PATTERN) }
      return parse_tags(nil) if tags.nil?
      $1.strip.split(",").map {|tag| tag.strip}
    end

    def self.parse_version(header : Nil)
      nil
    end

    def self.parse_version(header : String)
      header.lines.find {|line| line.match(VERSION_PATTERN) } ? $1.strip : nil
    end

    def self.parse_author(header : Nil)
      nil
    end

    def self.parse_author(header : String)
      header.lines.find {|line| line.match(AUTHOR_PATTERN) } ? $1.strip : nil
    end

    property header  : String?
    property tags    : Array(String)
    property file    : String?
    property version : String?
    property author  : String?

    def initialize(build : Build, file : String, @source : String)
      @header  = HeaderParser.parse_headers(@source)
      @tags    = HeaderParser.parse_tags(@header)
      @version = HeaderParser.parse_version(@header)
      @author  = HeaderParser.parse_author(@header)
      @file    = write(build, file)
    end

    def write(build, file)
      return nil if @header.nil?
      basename = File.basename(file)
      header_file = "%s.header" % basename.gsub(".lic", "")
      File.write(File.join(build.headers, header_file), @header)
      "/headers/%s" % header_file
    end
  end
end