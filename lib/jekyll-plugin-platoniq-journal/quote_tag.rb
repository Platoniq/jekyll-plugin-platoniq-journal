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

      output << %(<blockquote class="pj-quote">)
      output << Kramdown::Document.new(text).to_html if text
      output << <<~QUOTE
        <cite>
          #{jdata["author"]}
        </cite>
      QUOTE
      output << %(</blockquote>)

      output.join
    end
  end
end

Liquid::Template.register_tag("quote", Jekyll::QuoteBlockTag)
