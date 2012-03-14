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
  
  has_many :photos
  
  validates_uniqueness_of :twitter_id
  
  validates_presence_of :raw_feed
  
  after_create :get_media
  
  private
  
  def get_media
    for media in self.media.to_s.split(",") do
      file = Tempfile.new([self.twitter_id,".jpg"])
      file.binmode
      open(URI.parse("#{YAML::load(media)['source']}:large")) do |data|  
        file.write data.read
      end
      file.rewind
      Photo.create(:image => file, :tweet_id => self.id)
		end
  end
  
end
