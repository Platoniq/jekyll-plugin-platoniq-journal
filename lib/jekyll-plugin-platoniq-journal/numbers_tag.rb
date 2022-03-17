# frozen_string_literal: true

module Jekyll
  class NumbersTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "numbers"
    end
  end
end

Liquid::Template.register_tag("numbers", Jekyll::NumbersTag)
