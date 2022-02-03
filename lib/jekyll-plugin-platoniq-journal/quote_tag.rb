# frozen_string_literal: true

module Jekyll
  class QuoteBlockTag < Liquid::Block
    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(_context)
      text = super

      jdata = if !@input.nil? && !@input.empty?
                JSON.parse(@input)
              else
                JSON.parse({ :example => "123" })
              end

      output = []

      output << %(<figure class="pj-quote">)
      output << <<~QUOTE
        <blockquote>
          #{text}
        </blockquote>
        <figcaption class="pj-quote--author">
          by #{jdata["author"]}
        </figcaption>
      QUOTE
      output << %(</figure>)

      output.join
    end
  end
end

Liquid::Template.register_tag("quote", Jekyll::QuoteBlockTag)
