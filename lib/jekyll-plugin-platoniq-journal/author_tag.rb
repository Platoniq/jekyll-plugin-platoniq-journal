# frozen_string_literal: true

module Jekyll
  class AuthorTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "author"
    end
  end
end

Liquid::Template.register_tag("author", Jekyll::AuthorTag)
