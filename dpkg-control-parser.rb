#!/bin/ruby
#
# DpkgControlParser
# Version: 0.1.0
#
# Usage in Ruby code:
#   DpkgControlParser.parse([controlfile]) => controlhash [Hash(Hash(Array))]
#   DpkgControlParser.printAsJson([controlhash]) => [nil]
#
# Purpose:
#   This Ruby script will parse Debian control file.
#
# Copyright: 2019 Jongmin Kim <jmkim@pukyong.ac.kr>
# License: Expat

DEBIAN_CONTROL_FILE_REGEX = /^(([A-Za-z-]*): *| +)(.*|.+)/

module DpkgControlParser
  # Parse d/control file and store as Ruby object
  # Reference: https://www.debian.org/doc/debian-policy/ch-controlfields.html
  #
  # Hash[1] - Hash[2] - Array[3]
  # [1] Package name or Source name (with src: prefix)
  # [2] Field name
  # [3] Field values (delimiter is newline)
  #
  # @controlfile [IO-like object] Debian control file
  def DpkgControlParser.parse(controlfile)
    controlhash = Hash.new

    current_package = ""
    current_field = ""

    controlfile.each do |line|
      match = DEBIAN_CONTROL_FILE_REGEX.match(line)

      # Empty line, ignore
      unless match != nil
        next;
      end

      # Start of package
      if match[2] == "Package"
        current_package = match[3]

      # Start of source package
      elsif match[2] == "Source"
        current_package = "src:#{match[3]}"

      # Fields in package/source package
      else
        # Start of field
        if match[2] != nil
          current_field = match[2]

          # Set package name if not exists
          unless controlhash[current_package] != nil
            controlhash[current_package] = Hash.new
          end

          # Set field name if not exists
          unless controlhash[current_package][current_field] != nil
            controlhash[current_package][current_field] = Array.new
          end
        end

        # Put the field value
        controlhash[current_package][current_field].push(match[3])
      end
    end

    return controlhash
  end

  # Print as JSON format
  # @controlhash [Hash(Hash(Array))] controlhash made with DpkgControlParser.parse
  def DpkgControlParser.printAsJson(controlhash)
    puts "{"

    controlhash.each do |pkgname, fields|
      puts "\t\"#{pkgname}\": {"

      fields.each do |name, value|
        puts "\t\t\"#{name}\": #{value}"
      end

      puts "\t}," # TODO: Remove trailing comma
    end

    puts"}," # TODO: Remove trailing comma
    return nil
  end
end
