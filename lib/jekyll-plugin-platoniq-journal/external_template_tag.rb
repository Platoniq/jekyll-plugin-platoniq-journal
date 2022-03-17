# frozen_string_literal: true

module JekyllPluginPlatoniqJournal
  class ExternalTemplateTag < Liquid::Tag
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

      include_template = nil

      @context.stack do
        @context[include_name] = jdata
        include_template = inclusion.render(@context)
      end

      include_template
    end

    protected

    def tag_name
      raise NotImplementedError
    end

    def include_name
      tag_name
    end

    private

    def jdata
      @jdata ||= JSON.parse(@input.strip) if !@input.nil? && !@input.empty?
    end

    def include_file_path
      @include_file_path ||= "plugins/#{tag_name}.liquid"
    end
  end
end
