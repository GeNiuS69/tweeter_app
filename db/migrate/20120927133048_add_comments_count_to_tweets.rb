class AddCommentsCountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :comments_count, :integer, :default => 0
  end
end
