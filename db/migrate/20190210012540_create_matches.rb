class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :league_id
      t.jsonb :data
    end
  end
end
