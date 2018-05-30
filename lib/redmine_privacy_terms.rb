module RedminePrivacyTerms
  INSPECTOR_DOC_URL = 'https://github.com/alphanodes/redmine_privacy_terms/blob/master/INSPECTORS.md'.freeze

  class << self
    include Additionals::Helpers

    def setup
      # Patches
      Additionals.patch(%w[ApplicationController
                           SettingsHelper
                           User], 'redmine_privacy_terms')

      # Macros
      Additionals.load_macros(%w[terms_accept terms_reject], 'redmine_privacy_terms')

      # hooks
      require_dependency 'redmine_privacy_terms/hooks'
    end

    def settings
      ActionController::Parameters.new(Setting[:plugin_redmine_privacy_terms])
    end

    def setting?(value)
      Additionals.true?(settings[value])
    end

    def valid_terms_url?
      page = RedminePrivacyTerms.settings[:terms_page]
      return if page.blank? || external_page?(page)
      project_id = RedminePrivacyTerms.settings[:terms_project_id]
      return if project_id.blank?
      project = Project.find(project_id)
      wiki_page = project.wiki.find_page(page)
      return true if wiki_page.present?
    end

    def valid_terms_reject_url?
      page = RedminePrivacyTerms.settings[:terms_reject_page]
      return if page.blank?
      return true if external_page?(page)

      project_id = RedminePrivacyTerms.settings[:terms_reject_project_id]
      return if project_id.blank?
      project = Project.find(project_id)
      wiki_page = project.wiki.find_page(page)
      return true if wiki_page.present?
    end

    def terms_url(lang = nil)
      page = RedminePrivacyTerms.settings[:terms_page]
      project = Project.find(RedminePrivacyTerms.settings[:terms_project_id])

      if lang
        i18n_page = additionals_title_for_locale(page, lang)
        wiki_page = project.wiki.find_page(i18n_page)
        page = i18n_page if wiki_page.present?
      end

      Rails.application.routes.url_helpers.url_for(only_path: true,
                                                   controller: 'wiki',
                                                   action: 'show',
                                                   project_id: project,
                                                   id: Wiki.titleize(page))
    end

    def terms_reject_url(lang = nil)
      page = RedminePrivacyTerms.settings[:terms_reject_page]
      return page if external_page?(page)

      project = Project.find(RedminePrivacyTerms.settings[:terms_reject_project_id])

      if lang
        i18n_page = additionals_title_for_locale(page, lang)
        wiki_page = project.wiki.find_page(i18n_page)
        page = i18n_page if wiki_page.present?
      end

      Rails.application.routes.url_helpers.url_for(only_path: true,
                                                   controller: 'wiki',
                                                   action: 'show',
                                                   project_id: project,
                                                   id: Wiki.titleize(page))
    end

    def external_page?(page)
      return true if page.include?('http:') || page.include?('https:')
    end
  end
end
