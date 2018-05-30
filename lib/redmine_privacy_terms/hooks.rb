module RedminePrivacyTerms
  class RedminePrivacyTermssHookListener < Redmine::Hook::ViewListener
    render_on(:view_layouts_base_html_head, partial: 'redmine_privacy_terms/html_head')
    render_on(:view_users_show_info, partial: 'users/privacy_terms_show')
  end
end
