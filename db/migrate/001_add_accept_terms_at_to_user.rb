class AddAcceptTermsAtToUser < Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :users, :accept_terms_at, :datetime
  end
end
