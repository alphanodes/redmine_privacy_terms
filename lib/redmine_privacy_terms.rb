module RedminePrivacyTerms
  INSPECTOR_DOC_URL = 'https://github.com/alphanodes/redmine_privacy_terms/blob/master/INSPECTORS.md'.freeze

  class << self
    include Additionals::Helpers

    def setup
      # Patches
      Additionals.patch(%w[ApplicationController
                           User], 'redmine_privacy_terms')

      # Helper
      SettingsController.send :helper, PrivacyTermsHelper

      # Macros
      Additionals.load_macros 'redmine_privacy_terms'

      # hooks
      require_dependency 'redmine_privacy_terms/hooks'
    end

    # support with default setting as fall back
    def setting(value)
      if settings.key? value
        settings[value]
      else
        Additionals.load_settings('redmine_privacy_terms')[value]
      end
    end

    def setting?(value)
      Additionals.true?(settings[value])
    end

    def valid_terms_url?
      page = setting(:terms_page)
      return if page.blank? || external_page?(page)

      project_id = setting(:terms_project_id)
      return if project_id.blank?

      project = Project.find_by(id: project_id)
      return if project.blank?

      wiki_page = project.wiki.find_page(page)
      return true if wiki_page.present?
    end

    def valid_terms_reject_url?
      page = setting(:terms_reject_page)
      return if page.blank?
      return true if external_page?(page)

      project_id = setting(:terms_reject_project_id)
      return if project_id.blank?

      project = Project.find_by(id: project_id)
      return if project.blank?

      wiki_page = project.wiki.find_page(page)
      return true if wiki_page.present?
    end

    def terms_url(lang = nil)
      page = setting(:terms_page)
      project = Project.find_by(id: setting(:terms_project_id))

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
      page = setting(:terms_reject_page)
      return page if external_page?(page)

      project = Project.find_by(id: setting(:terms_reject_project_id))

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

    def additionals_help_items
      [{ title: 'Privacy & Terms',
         url: 'https://github.com/AlphaNodes/redmine_privacy_terms/blob/master/README.md',
         admin: true }]
    end

    private

    def settings
      Setting[:plugin_redmine_privacy_terms]
    end
  end
end
