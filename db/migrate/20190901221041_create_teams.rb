class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :tla
      t.text :name
      t.text :short_name
      t.text :crest_url
      t.text :address
      t.text :phone
      t.text :website
      t.text :email
      t.text :founded
      t.text :club_colors
      t.text :venue
      t.datetime :external_last_updated

      t.timestamps
    end
  end
end
