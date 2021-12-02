# frozen_string_literal: true

module RedminePrivacyTerms
  module Hooks
    class RedminePrivacyTermssHookListener < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head, partial: 'redmine_privacy_terms/html_head'
      render_on :view_users_show_info, partial: 'users/privacy_terms_show'

      def after_plugins_loaded(_context = {})
        RedminePrivacyTerms.setup if Rails.version > '6.0'
      end
    end
  end
end
