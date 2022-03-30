# frozen_string_literal: true

loader = RedminePluginKit::Loader.new plugin_id: 'redmine_privacy_terms'

Redmine::Plugin.register :redmine_privacy_terms do
  name 'Redmine Privacy & Terms'
  url 'https://github.com/alphanodes/redmine_privacy_terms'
  description 'Add privacy cookie information and terms for users'
  version RedminePrivacyTerms::VERSION
  author 'AlphaNodes GmbH'
  author_url 'https://alphanodes.com/'

  begin
    requires_redmine_plugin :additionals, version_or_higher: '3.0.6'
  rescue Redmine::PluginNotFound
    raise 'Please install additionals plugin (https://github.com/alphanodes/additionals)'
  end

  permission :show_terms_condition, {}

  settings default: loader.default_settings,
           partial: 'redmine_privacy_terms/settings/settings'
end

RedminePluginKit::Loader.persisting { loader.load_model_hooks! }
