# frozen_string_literal: true

module Jekyll
  class StickersTag < Liquid::Tag
    include JekyllPluginPlatoniqJournal::Base
    include JekyllPluginPlatoniqJournal::IncludesFile

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      super
      @context = context
      @site = site

      @site.inclusions[include_file_path] ||= locate_include_file(include_file_path)
      add_include_to_dependency(inclusion, @context) if site.config["incremental"]

      include_stickers = nil

      @context.stack do
        context["include"] = jdata
        include_stickers = inclusion.render(@context)
      end

      include_stickers
    end

    private

    def jdata
      @jdata ||= JSON.parse(@context[@input.strip]) if !@input.nil? && !@input.empty?
    end

    def include_file_path
      @include_file_path ||= "plugins/stickers.liquid"
    end
  end
end

Liquid::Template.register_tag("stickers", Jekyll::StickersTag)
