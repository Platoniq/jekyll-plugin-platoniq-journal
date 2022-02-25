# frozen_string_literal: true

module Jekyll
  class FileTag < Liquid::Block
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

      output
    end

    private

    def jdata
      @jdata ||= JSON.parse(@input) if !@input.nil? && !@input.empty?
    end

    def include_file_path
      @include_file_path ||= if !jdata.nil? && jdata["icon"]
                               jdata["icon"]
                             else
                               "svg/icon-download.liquid"
                             end
    end

    def output
      <<~FILE
        <section class="cta-box cta-box--file">
          <div class="cta-box__img">
            <img src="#{jdata["image"]} alt="#{jdata["title"]}"/>
          </div>

          <div class="cta-box__text">
            <h3>#{jdata["title"]}</h3>
          </div>

          <div class="cta-box__cta">
            <a href="#{jdata["file"]}" target="_blank" class="btn btn--negatiu">
              #{@icon}
              <span class="btn__label">#{localize("download")}</span>
            </a>
          </div>
        </section>
      FILE
    end
  end
end

Liquid::Template.register_tag("file", Jekyll::FileTag)
