# frozen_string_literal: true

module Jekyll
  class GalleryTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "gallery"
    end
  end
end

Liquid::Template.register_tag("gallery", Jekyll::GalleryTag)
