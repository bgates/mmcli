# frozen_string_literal: true

require 'mmcli/version'
require 'methadone'
require 'fileutils'

module Mmcli
  PREFIX = ENV['ARUBA_HACK'] ? File.expand_path(File.join(__dir__, '..', 'tmp', 'aruba')) : nil

  # Manifest makes changes to the manifest file. It's called by App (in ../bin/mmcli)
  class Manifest
    include Methadone::CLILogging

    def self.add!(file_path, list)
      info 'adding files...'
      File.open(file_path, 'a+') do |f|
        lines_sans_newlines = f.readlines.map(&:chomp)
        failures = list.uniq.each_with_object([]) do |path, array|
          write_or_save_for_report(f, path, lines_sans_newlines, array)
        end
        report(failures)
      end
    end

    def self.clean!(file_path)
      info 'cleaning manifest...'
      delete!(file_path, nil) do |line|
        chomped = line.chomp
        hack_path = PREFIX ? "#{PREFIX}#{chomped}" : File.absolute_path(chomped)
        !File.exist?(hack_path)
      end
      info 'manifest clean'
    end

    def self.delete!(file_path, list)
      info 'deleting files...' if list # so cleaning doesn't generate this msg
      File.open(file_path, 'r') do |f|
        File.open("#{file_path}.tmp", 'w') do |f2|
          f.each_line do |line|
            f2.write(line) unless yield(line, list)
          end
        end
      end
      FileUtils.mv "#{file_path}.tmp", file_path
      info 'files deleted' if list
    end

    def self.hack_for(path)
      PREFIX ? path.sub(PREFIX, '') : File.absolute_path(path)
    end

    def self.list_contents(file_path)
      File.open(file_path, 'r') do |f|
        f.each_line { |line| puts line }
      end
    end

    def self.report(failures)
      if failures.empty?
        info 'all files added'
      else
        info "the following paths were not added because no such files exist: #{failures.join(', ')}"
      end
    end

    def self.write_or_save_for_report(f, path, lines_sans_newlines, array)
      if File.exist?(path)
        f.puts hack_for(path) unless lines_sans_newlines.include?(hack_for(path))
      else
        array << path
      end
    end
  end
end
