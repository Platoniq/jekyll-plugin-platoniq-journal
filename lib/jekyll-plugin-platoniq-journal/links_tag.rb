# frozen_string_literal: true

module Jekyll
  class LinksTag < Liquid::Tag
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(_context)
      jdata = if !@input.nil? && !@input.empty?
                JSON.parse(@input)
              else
                JSON.parse({ :example => "123" })
              end

      output = []

      output << %(<section class="pj-links">)
      output << %(<h3>#{jdata["title"]}</h3>)
      output << %(<ul class="llistat-links">)
      output << jdata["items"].map { |item| render_item(item) }
      output << %(</ul></section>)

      output.join
    end

    private

    def render_item(item)
      <<~LINK
        <li>
          <a href="#{item["url"]}" class="link link--extern">
            <span class="link__icon link__icon--left">
              <img src="img/ico/links--primary.svg" alt="#{item["title"]}">
            </span>
            <span class="link__label">
              #{item["title"]}
            </span>
          </a>
        </li>
      LINK
    end
  end
end

Liquid::Template.register_tag("links", Jekyll::LinksTag)
