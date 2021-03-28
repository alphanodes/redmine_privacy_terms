# frozen_string_literal: true

module RedminePrivacyTerms
  module WikiMacros
    Redmine::WikiFormatting::Macros.register do
      desc <<-DESCRIPTION
        Add terms accept macro

        Syntax:

        {{terms_accept([title=TEXT, title_de=TEXT, ...)}}

        You can use all language as suffix, eg. title_de, button_it, button_es

        Examples:

        {{terms_accept}}
        {{terms_accept(title=Ok understood)}}
        {{terms_accept(title='Ok, understood' title_de='Alles klar')}}

      DESCRIPTION

      macro :terms_accept do |_obj, args|
        title = if args.any?
                  options = extract_macro_options(args, *additionals_titles_for_locale(:title)).last
                  additionals_i18n_title(options, :title)
                end

        link_to(title.presence || l(:label_default_accept_terms),
                accept_terms_path,
                class: 'accept-terms-button')
      end
    end
  end
end
