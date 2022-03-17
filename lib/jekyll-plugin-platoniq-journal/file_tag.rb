# frozen_string_literal: true

module Jekyll
  class FileTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "file"
    end
  end
end

Liquid::Template.register_tag("file", Jekyll::FileTag)
