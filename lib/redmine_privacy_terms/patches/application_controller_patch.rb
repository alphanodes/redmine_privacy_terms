# frozen_string_literal: true

module RedminePrivacyTerms
  module Patches
    module ApplicationControllerPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods

        before_action :check_agreement
      end

      module InstanceMethods
        private

        def check_agreement
          return unless RedminePrivacyTerms.valid_terms_url? &&
                        RedminePrivacyTerms.valid_terms_reject_url? &&
                        need_accept_terms? &&
                        !allowed_path?

          if api_request?
            render_error message: 'Terms not accepted', status: 403
          else
            redirect_to RedminePrivacyTerms.terms_url(::I18n.locale)
          end
        end

        def need_accept_terms?
          RedminePrivacyTerms.setting?(:enable_terms) &&
            User.current.logged? &&
            !User.current.admin? &&
            !twofa_activation_pending? &&
            !User.current.accept_terms?
        end

        # Redmine sends users with a pending 2FA setup to the activation pages and
        # skips its own check_twofa_activation filter there. Asking for the terms in
        # between would bounce the user between both redirects until the browser
        # gives up. Mirrors the condition of ApplicationController#check_twofa_activation,
        # so the terms check only pauses while Redmine actually enforces the setup.
        def twofa_activation_pending?
          session[:must_activate_twofa].present? && User.current.must_activate_twofa?
        end

        def allowed_path?
          [accept_terms_path,
           reject_terms_path,
           signout_path,
           my_password_path,
           RedminePrivacyTerms.terms_url(::I18n.locale),
           RedminePrivacyTerms.terms_reject_url(::I18n.locale)].include?(request.original_fullpath)
        end
      end
    end
  end
end
