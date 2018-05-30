module RedminePrivacyTerms
  module Patches
    module UserPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def accept_terms?
          accept_terms_at
        end
      end
    end
  end
end
