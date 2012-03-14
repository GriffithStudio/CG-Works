class Tweet < ActiveRecord::Base
  # t.text :text
  # t.integer :twitter_id
  # t.boolean :is_retweet
  # t.text :media
  # t.text :raw_feed
  # t.text :hashtags
  # t.text :mentions
  # t.text :links
  # t.boolean :display, :default => true
  
  attr_accessible :twitter_id, :raw_feed, :text, :is_retweet, :posted_at, :media, :hashtags, :mentions, :links
                        
  validates_uniqueness_of :twitter_id
  
  validates_presence_of :raw_feed
  
end
