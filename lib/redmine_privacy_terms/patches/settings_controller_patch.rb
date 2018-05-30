module RedminePrivacyTerms
  module Patches
    module SettingsControllerPatch
      def self.included(base)
        base.class_eval do
          helper :privacy_terms
        end
      end
    end
  end
end
