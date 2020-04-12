module RedminePrivacyTerms
  module Patches
    module UserPatch
      def accept_terms?
        accept_terms_at
      end
    end
  end
end
