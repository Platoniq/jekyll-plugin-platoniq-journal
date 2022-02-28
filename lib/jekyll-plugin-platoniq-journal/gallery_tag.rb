# frozen_string_literal: true

module Jekyll
  class GalleryTag < Liquid::Tag
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

      include_gallery = nil

      @context.stack do
        @context["gallery"] = jdata
        include_gallery = inclusion.render(@context)
      end

      include_gallery
    end

    private

    def jdata
      @jdata ||= JSON.parse(@input.strip) if !@input.nil? && !@input.empty?
    end

    def include_file_path
      @include_file_path ||= "plugins/gallery.liquid"
    end
  end
end

Liquid::Template.register_tag("gallery", Jekyll::GalleryTag)
