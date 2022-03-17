# frozen_string_literal: true

module Jekyll
  class DocumentsTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "documents"
    end
  end
end

Liquid::Template.register_tag("documents", Jekyll::DocumentsTag)
