# frozen_string_literal: true

module RedminePrivacyTerms
  VERSION = '1.0.7'
  INSPECTOR_DOC_URL = 'https://github.com/alphanodes/redmine_privacy_terms/blob/master/INSPECTORS.md'

  include RedminePluginKit::PluginBase

  class << self
    include Additionals::Helpers

    def valid_terms_url?
      page = setting :terms_page
      return false if page.blank? || external_page?(page)

      project_id = setting :terms_project_id
      return false if project_id.blank?

      project = Project.find_by id: project_id
      return false if project.blank?

      wiki_page = project.wiki&.find_page page
      return true if wiki_page.present?

      false
    end

    def valid_terms_reject_url?
      page = setting :terms_reject_page
      return false if page.blank?
      return true if external_page? page

      project_id = setting :terms_reject_project_id
      return false if project_id.blank?

      project = Project.find_by id: project_id
      return false if project.blank?

      wiki_page = project.wiki&.find_page page
      return true if wiki_page.present?

      false
    end

    def terms_url(lang = nil)
      page = setting :terms_page
      project = Project.find_by id: setting(:terms_project_id)

      if lang
        i18n_page = additionals_title_for_locale page, lang
        wiki_page = project.wiki&.find_page i18n_page
        page = i18n_page if wiki_page.present?
      end

      Rails.application.routes.url_helpers.url_for(only_path: true,
                                                   controller: 'wiki',
                                                   action: 'show',
                                                   project_id: project,
                                                   id: Wiki.titleize(page))
    end

    def terms_reject_url(lang = nil)
      page = setting :terms_reject_page
      return page if external_page? page

      project = Project.find_by id: setting(:terms_reject_project_id)

      if lang
        i18n_page = additionals_title_for_locale page, lang
        wiki_page = project.wiki&.find_page i18n_page
        page = i18n_page if wiki_page.present?
      end

      Rails.application.routes.url_helpers.url_for(only_path: true,
                                                   controller: 'wiki',
                                                   action: 'show',
                                                   project_id: project,
                                                   id: Wiki.titleize(page))
    end

    def external_page?(page)
      page.include?('http:') || page.include?('https:')
    end

    private

    def setup
      # Patches
      loader.add_patch %w[ApplicationController
                          User]

      # Helper
      loader.add_helper({ controller: SettingsController, helper: 'PrivacyTerms' })

      # Apply patches and helper
      loader.apply!

      # Macros
      loader.load_macros!

      # Load view hooks
      loader.load_view_hooks!
    end
  end
end
