# frozen_string_literal: true

module Jekyll
  class NumbersTag < Liquid::Tag
    include JekyllPluginPlatoniqJournal::Base
    include JekyllPluginPlatoniqJournal::IncludesFile

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end

    def render(context)
      @context = context
      @site = site

      @site.inclusions[icon_file_path] ||= locate_include_file(icon_file_path)

      add_include_to_dependency(inclusion, context) if site.config["incremental"]

      @icon = nil
      context.stack do
        @icon = inclusion.render(context)
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
              <span class="pj-number--icon">#{@icon}</span>
              #{key}
            </span>
          </li>
        NUM
      end
      output << %(</ul>)

      output.join
    end

    private

    def jdata
      @jdata ||= if !@input.nil? && !@input.empty?
                   JSON.parse(@input)
                 else
                   JSON.parse({ :example => "123" })
                 end
    end

    def icon_file_path
      @icon_file_path ||= if !jdata.nil? && jdata["icon"]
                            jdata["icon"]
                          else
                            "svg/icon-arrow_leftup.liquid"
                          end
    end
  end
end

Liquid::Template.register_tag("numbers", Jekyll::NumbersTag)
