# frozen_string_literal: true

module Jekyll
  class QuoteBlock < Liquid::Block
    include JekyllPluginPlatoniqJournal::Base
    include JekyllPluginPlatoniqJournal::IncludesFile

    def initialize(block_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      text = super
      @context = context
      @site = site

      @site.inclusions[include_file_path] ||= locate_include_file(include_file_path)

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

    def include_file_path
      @include_file_path ||= if !jdata.nil? && jdata["icon"]
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
      return if jdata.nil?

      author_name = jdata["author"]
      return if author_name.nil? || author_name == ""

      @author ||= <<~AUTHOR
        <figcaption class="pj-quote-author">
          #{localize("authored_by")} #{author_name}
        </figcaption>
      AUTHOR
    end

    def output(text, icon)
      output = []
      output << %(<figure class="pj-quote">)
      output << quote(text, icon)
      output << author if author
      output << %(</figure>)
      output
    end
  end
end

Liquid::Template.register_tag("quote", Jekyll::QuoteBlock)
