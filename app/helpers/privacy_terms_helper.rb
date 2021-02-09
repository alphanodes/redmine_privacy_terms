module PrivacyTermsHelper
  def privacy_terms_inspect_results
    rc = []
    rc << { name: l(:label_authentication),
            id: 'authentication',
            value: inspect_bool_value(Setting.login_required?),
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

    inactive_users = User.active.where('last_login_on < ?', Time.zone.now - 1.year).count
    rc << { name: l(:inspect_user_inactive_over_one_year),
            id: 'inactive_users',
            value: inactive_users,
            result: inspect_bool_result(inactive_users.zero?) }

    if RedminePrivacyTerms.setting?(:enable_terms)
      terms_not_accepted = User.active.where(admin: false).where(accept_terms_at: nil).count
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
                                        down_icon: 'fas_info',
                                        down_class: 'inspect-info') }

    rc
  end

  private

  def inspect_bool_value(value)
    if value
      l(:general_text_Yes)
    else
      l(:general_text_No)
    end
  end

  def inspect_bool_result(value, options = {})
    options[:down_icon] = 'far_thumbs-down' if options[:down_icon].blank?
    options[:down_class] = 'additionals-number-negative inspect-problem' if options[:down_class].blank?

    if value
      font_awesome_icon('far_thumbs-up', class: 'additionals-number-positive inspect-good')
    else
      font_awesome_icon(options[:down_icon], class: options[:down_class])
    end
  end
end
