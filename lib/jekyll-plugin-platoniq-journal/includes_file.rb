# frozen_string_literal: true

module JekyllPluginPlatoniqJournal
  module IncludesFile
    def inclusion
      @inclusion ||= @site.inclusions[icon_file_path]
    end

    ## Methods below from Jekyll::Tags::OptimizedIncludeTag
    # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/tags/include.rb
    ##

    def locate_include_file(file)
      site.includes_load_paths.each do |dir|
        path = PathManager.join(dir, file)
        return Inclusion.new(site, dir, file) if valid_include_file?(path, dir)
      end
      raise IOError, could_not_locate_message(file, @site.includes_load_paths, @site.safe)
    end

    def valid_include_file?(path, dir)
      File.file?(path) && !outside_scope?(path, dir)
    end

    def outside_scope?(path, dir)
      @site.safe && !realpath_prefixed_with?(path, dir)
    end

    def realpath_prefixed_with?(path, dir)
      File.realpath(path).start_with?(dir)
    rescue StandardError
      false
    end

    def could_not_locate_message(file, includes_dirs, safe)
      message = "Could not locate the included file '#{file}' in any of "\
        "#{includes_dirs}. Ensure it exists in one of those directories and"
      message + if safe
                  " is not a symlink as those are not allowed in safe mode."
                else
                  ", if it is a symlink, does not point outside your site source."
                end
    end
  end
end
