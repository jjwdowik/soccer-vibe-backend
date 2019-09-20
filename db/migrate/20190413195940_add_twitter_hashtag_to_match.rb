class AddTwitterHashtagToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :twitter_hashtag, :text
  end
end
