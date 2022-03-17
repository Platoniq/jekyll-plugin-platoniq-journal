# frozen_string_literal: true

module Jekyll
  class LinksTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "links"
    end
  end
end

Liquid::Template.register_tag("links", Jekyll::LinksTag)
