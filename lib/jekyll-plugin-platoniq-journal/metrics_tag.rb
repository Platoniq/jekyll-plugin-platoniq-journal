# frozen_string_literal: true

module Jekyll
  class MetricsTag < JekyllPluginPlatoniqJournal::ExternalTemplateTag
    def tag_name
      "metrics"
    end
  end
end

Liquid::Template.register_tag("metrics", Jekyll::MetricsTag)
