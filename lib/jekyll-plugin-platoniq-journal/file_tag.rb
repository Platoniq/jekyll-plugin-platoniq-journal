# frozen_string_literal: true

module Jekyll
  class FileTag < Liquid::Tag
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
        <section class="pj-file">
          <div class="pj-file__img">
            <img src="#{jdata["image"]}" alt="#{jdata["title"]}"/>
          </div>

          <div class="pj-file__text">
            <span class="pj-file__text__title">#{jdata["title"]}</span>
            #{info}
          </div>

          <div class="pj-file__button">
            <a href="#{jdata["file"]}" target="_blank" class="btn btn-negative">
              <span class="btn__icon btn__icon-left">
                #{@icon}
              </span>
              <span class="btn__label">#{localize("download")}</span>
            </a>
          </div>
        </section>
      FILE
    end

    def info
      return unless !jdata["info"].nil? && !jdata["info"].empty?

      <<~INFO
        <span class="pj-file__text__data">#{jdata["info"]}</span>
      INFO
    end
  end
end

Liquid::Template.register_tag("file", Jekyll::FileTag)
