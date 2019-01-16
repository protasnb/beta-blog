class AddPasswordDigestToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string
    rename_column :articles, :upated_at, :updated_at
  end
end
