# frozen_string_literal: true

module Jekyll
  class NumbersTag < Liquid::Tag
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

      output << %(<ul class="pj-numbers">)
      jdata.each do |key, value|
        output << <<~NUM
          <li>
            <strong>
              #{value}
            </strong>
            <span class="pj-number--description">
              #{key}
            </span>
          </li>
        NUM
      end
      output << %(</ul>)

      output.join
    end
  end
end

Liquid::Template.register_tag("numbers", Jekyll::NumbersTag)
