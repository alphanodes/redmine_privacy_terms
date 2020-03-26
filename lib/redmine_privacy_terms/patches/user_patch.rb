require_dependency 'user'

class User
  def accept_terms?
    accept_terms_at
  end
end
