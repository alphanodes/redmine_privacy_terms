class AddAcceptTermsAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :accept_terms_at, :datetime
  end
end
