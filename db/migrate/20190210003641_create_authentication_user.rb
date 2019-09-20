class CreateAuthenticationUser < ActiveRecord::Migration[5.2]
  def change
    create_table :authentication_users do |t|
      t.string :api_auth_token
      t.datetime :last_requested
      t.integer :requested_count, default: 0

      t.timestamps
    end
  end
end
