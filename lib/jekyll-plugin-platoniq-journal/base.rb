# frozen_string_literal: true

module JekyllPluginPlatoniqJournal
  module Base
    def site
      @site ||= @context.registers[:site]
    end

    def page
      @page ||= @context.registers[:page].to_liquid
    end

    def page_locale
      @page_locale ||= page["locale"] || "es"
    end

    def localize(key)
      site.data["i18n"][page_locale]["global"][key]
    end
  end
end
