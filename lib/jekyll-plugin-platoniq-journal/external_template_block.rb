# frozen_string_literal: true

module JekyllPluginPlatoniqJournal
  class ExternalTemplateBlock < Liquid::Block
    include JekyllPluginPlatoniqJournal::Base
    include JekyllPluginPlatoniqJournal::IncludesFile

    def initialize(block_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      content = super
      @context = context
      @site = site

      @site.inclusions[include_file_path] ||= locate_include_file(include_file_path)
      add_include_to_dependency(inclusion, @context) if site.config["incremental"]

      include_template = nil

      @context.stack do
        @context[include_name] = jdata.merge("content" => content)

        include_template = inclusion.render(@context)
      end

      include_template
    end

    protected

    def block_name
      raise NotImplementedError
    end

    def include_name
      block_name
    end

    private

    def jdata
      @jdata ||= (JSON.parse(@input.strip) if !@input.nil? && !@input.empty?) || {}
    end

    def include_file_path
      @include_file_path ||= "plugins/#{block_name}.liquid"
    end
  end
end
