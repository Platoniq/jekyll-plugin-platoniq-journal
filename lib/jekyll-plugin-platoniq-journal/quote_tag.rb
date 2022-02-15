# frozen_string_literal: true

# require "byebug"

module Jekyll
  class QuoteBlockTag < Liquid::Block
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      text = super
      @context = context
      @site = site

      @site.inclusions[icon_file_path] ||= locate_include_file(icon_file_path)

      add_include_to_dependency(inclusion, context) if site.config["incremental"]
      icon = nil
      context.stack do
        # context["include"] = parse_params(context) if @params
        icon = inclusion.render(context)
      end

      output(text, icon).join
    end

    private

    def jdata
      @jdata ||= JSON.parse(@input) if !@input.nil? && !@input.empty?
    end

    def page
      @page ||= @context.registers[:page].to_liquid
    end

    def page_locale
      @page_locale ||= page["locale"] || "en"
    end

    def site
      @site ||= @context.registers[:site]
    end

    def icon_file_path
      @icon_file_path ||= if !jdata.nil? && jdata["icon"]
                            jdata["icon"]
                          else
                            "svg/icon-quote.liquid"
                          end
    end

    def quote(text, icon)
      <<~QUOTE
        <blockquote>
          #{icon}

          #{text}
        </blockquote>
      QUOTE
    end

    def author
      if !jdata.nil? && jdata["author"]
        @author ||= <<~AUTHOR
          <figcaption class="pj-quote--author">
            #{t_authored_by} #{jdata["author"]}
          </figcaption>
        AUTHOR
      end
    end

    def t_authored_by
      @t_authored_by ||= site.data["i18n"][page_locale]["global"]["authored_by"]
    end

    def output(text, icon)
      output = []
      output << %(<figure class="pj-quote">)
      output << quote(text, icon)
      output << author if author
      output << %(</figure>)
      output
    end

    def inclusion
      @inclusion ||= @site.inclusions[icon_file_path]
    end

    ## Methods below from Jekyll::Tags::OptimizedIncludeTag
    # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/tags/include.rb
    ##

    def locate_include_file(file)
      @site.includes_load_paths.each do |dir|
        path = PathManager.join(dir, file)
        return Inclusion.new(@site, dir, file) if valid_include_file?(path, dir)
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

Liquid::Template.register_tag("quote", Jekyll::QuoteBlockTag)
