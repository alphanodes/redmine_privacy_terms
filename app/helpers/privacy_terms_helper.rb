# frozen_string_literal: true

module PrivacyTermsHelper
  def privacy_terms_inspect_results
    rc = []
    rc << { name: l(:label_authentication),
            id: 'authentication',
            value: format_yes(Setting.login_required?),
            result: inspect_bool_result(Setting.login_required?) }
    rc << { name: l(:setting_protocol),
            id: 'protocol',
            value: Setting.protocol,
            result: inspect_bool_result(Setting.protocol == 'https') }

    admin_amount = User.active.admin.count
    rc << { name: l(:inspect_admin_amount),
            id: 'admin_amount',
            value: admin_amount,
            result: inspect_bool_result(admin_amount < 2) }

    rc << { name: l(:setting_password_min_length),
            id: 'password_min_length',
            value: Setting.password_min_length,
            result: inspect_bool_result(Setting.password_min_length.to_i > 7) }

    roles_amount = Role.where(users_visibility: 'all').count
    rc << { name: l(:inspect_user_visibility),
            id: 'roles_users_visibility_all',
            value: roles_amount,
            result: inspect_bool_result(roles_amount.zero?) }

    inactive_users = User.active.where(last_login_on: ...1.year.ago).count
    rc << { name: l(:inspect_user_inactive_over_one_year),
            id: 'inactive_users',
            value: inactive_users,
            result: inspect_bool_result(inactive_users.zero?) }

    if RedminePrivacyTerms.setting? :enable_terms
      terms_not_accepted = User.active.where(admin: false, accept_terms_at: nil).count
      rc << { name: l(:inspect_user_terms_not_accepted),
              id: 'user_terms_not_accepted',
              value: terms_not_accepted,
              result: inspect_bool_result(terms_not_accepted.zero?) }
    end

    never_logedin_users = User.active.where(last_login_on: nil).count
    rc << { name: l(:inspect_never_logedin_users),
            id: 'never_logedin_users',
            value: never_logedin_users,
            result: inspect_bool_result(never_logedin_users.zero?) }

    public_projects = Project.all_public.count
    rc << { name: l(:label_public_projects),
            id: 'public_projects',
            value: public_projects,
            result: inspect_bool_result(public_projects.zero?,
                                        down_icon: 'details',
                                        down_class: 'summary') }

    rc
  end

  private

  def inspect_bool_result(value, down_icon: nil, down_class: nil)
    down_icon ||= 'thumb-down'
    down_class ||= 'additionals-number-negative inspect-problem'

    if value
      #      font_awesome_icon 'far_thumbs-up', class: 'additionals-number-positive inspect-good'
      svg_icon_tag 'thumb-up', css_class: 'additionals-number-positive inspect-good'
    else
      svg_icon_tag down_icon, css_class: down_class
    end
  end
end
