# frozen_string_literal: true

module Jekyll
  class VideoTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "video"
    end
  end
end

Liquid::Template.register_tag("video", Jekyll::VideoTag)
