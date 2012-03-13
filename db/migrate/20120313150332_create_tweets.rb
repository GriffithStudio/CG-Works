class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.integer :twitter_id
      t.boolean :is_retweet
      t.text :media
      t.text :raw_feed
      t.text :hashtags
      t.text :mentions
      t.text :links
      t.boolean :display, :default => true

      t.timestamps
    end
  end
end
