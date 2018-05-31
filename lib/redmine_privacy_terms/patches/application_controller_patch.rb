module RedminePrivacyTerms
  module Patches
    module ApplicationControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          before_action :check_agreement
        end
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
            !User.current.accept_terms?
        end

        def allowed_path?
          [accept_terms_path,
           reject_terms_path,
           signout_path,
           RedminePrivacyTerms.terms_url(::I18n.locale),
           RedminePrivacyTerms.terms_reject_url(::I18n.locale)].include?(request.original_fullpath)
        end
      end
    end
  end
end
