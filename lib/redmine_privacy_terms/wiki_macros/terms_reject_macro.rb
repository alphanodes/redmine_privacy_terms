# frozen_string_literal: true

module RedminePrivacyTerms
  module WikiMacros
    Redmine::WikiFormatting::Macros.register do
      desc <<-DESCRIPTION
        Add terms reject macro

        Syntax:

        {{terms_reject([title=TEXT, title_de=TEXT, ...)}}

        You can use all language as suffix, eg. title_de, button_it, button_es

        Examples:

        {{terms_reject}}
        {{terms_reject(title='Reject')}}
        {{terms_reject(title='Reject' title_de='Ich stimme nicht zu')}}

      DESCRIPTION

      macro :terms_reject do |_obj, args|
        title = if args.any?
                  options = extract_macro_options(args, *additionals_titles_for_locale(:title)).last
                  additionals_i18n_title options, :title
                end
        link_to(title.presence || l(:label_default_reject_terms),
                reject_terms_path,
                class: 'reject-terms-button')
      end
    end
  end
end
