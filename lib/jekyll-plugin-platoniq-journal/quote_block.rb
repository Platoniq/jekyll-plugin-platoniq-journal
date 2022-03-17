# frozen_string_literal: true

module Jekyll
  class QuoteBlock < JekyllPluginPlatoniqJournal::ExternalTemplateBlock
    def block_name
      "quote"
    end
  end
end

Liquid::Template.register_tag("quote", Jekyll::QuoteBlock)
