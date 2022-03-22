# frozen_string_literal: true

module Jekyll
  class QuestionsTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "questions"
    end
  end
end

Liquid::Template.register_tag("questions", Jekyll::QuestionsTag)
