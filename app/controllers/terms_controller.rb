# frozen_string_literal: true

class TermsController < ApplicationController
  before_action :require_login
  before_action :check_terms_active, only: %i[accept reject]
  before_action :require_admin, only: %i[reset]

  def accept
    User.current.update accept_terms_at: Time.zone.now
    redirect_to home_url
  end

  def reject
    User.current.update accept_terms_at: nil
    redirect_to RedminePrivacyTerms.terms_reject_url(::I18n.locale)
  end

  def reset
    User.update_all accept_terms_at: nil
    Setting.plugin_redmine_privacy_terms = RedminePrivacyTerms.send(:settings).merge last_terms_reset: Time.now.utc.to_s
    flash[:notice] = l :notice_terms_reset_successfully
    redirect_to plugin_settings_path(id: 'redmine_privacy_terms', tab: 'tools')
  end

  private

  def check_terms_active
    if RedminePrivacyTerms.setting? :enable_terms
      true
    else
      flash[:warning] = l :notice_terms_accepted_not_saved
      redirect_to home_url
    end
  end
end
