# frozen_string_literal: true

raise "\n\033[31maredmine_privacy_terms requires ruby 2.6 or newer. Please update your ruby version.\033[0m" if RUBY_VERSION < '2.6'

Redmine::Plugin.register :redmine_privacy_terms do
  name 'Redmine Privacy & Terms'
  url 'https://github.com/alphanodes/redmine_privacy_terms'
  description 'Add privacy cookie information and terms for users'
  version RedminePrivacyTerms::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.1'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  permission :show_terms_condition, {}

  settings default: Additionals.load_settings('redmine_privacy_terms'), partial: 'redmine_privacy_terms/settings/settings'
end

Rails.configuration.to_prepare do
  RedminePrivacyTerms.setup
end
