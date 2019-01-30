class AddKeysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :consumer_key, :string
    add_column :users, :consumer_secret, :string
    add_column :users, :access_token, :string
    add_column :users, :access_token_secret, :string
  end
end
