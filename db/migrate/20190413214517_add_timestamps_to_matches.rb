class AddTimestampsToMatches < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :matches, default: Time.zone.now
    change_column_default :matches, :created_at, nil
    change_column_default :matches, :updated_at, nil
  end
end
