# frozen_string_literal: true

module Jekyll
  class DocumentsTag < Liquid::Tag
    include JekyllPluginPlatoniqJournal::Base
    include JekyllPluginPlatoniqJournal::IncludesFile

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      @context = context
      @site = site

      @site.inclusions[include_file_path] ||= locate_include_file(include_file_path)

      add_include_to_dependency(inclusion, context) if site.config["incremental"]

      @icon = nil
      context.stack do
        @icon = inclusion.render(context)
      end

      render_all
    end

    private

    def jdata
      @jdata ||= JSON.parse(@input) if !@input.nil? && !@input.empty?
    end

    def include_file_path
      "svg/icon-document.liquid"
    end

    def render_all
      output = []

      output << %(<section class="pj-links">)
      output << render_title unless jdata["title"].empty?
      output << render_list if jdata["items"].any?
      output << %(</section>)

      output.join
    end

    def render_title
      %(<h3>#{jdata["title"]}</h3>)
    end

    def render_list
      output = []

      output << %(<ul class="llistat-links">)
      output << jdata["items"].map { |item| render_item(item) }
      output << %(</ul>)

      output.join
    end

    def render_item(item)
      <<~DOCUMENT
        <li>
          <a href="#{item["file"]}" class="link link--extern" target="_blank">
            <span class="link__icon link__icon--left">
              #{@icon}
            </span>
            <span class="link__label">
              #{item["title"]}
            </span>
          </a>
        </li>
      DOCUMENT
    end
  end
end

Liquid::Template.register_tag("documents", Jekyll::DocumentsTag)
