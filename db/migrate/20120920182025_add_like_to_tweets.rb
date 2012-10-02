class AddLikeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :likes, :integer, :default => 0
  end
end
