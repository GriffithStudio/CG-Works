class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :need_scrapbook_update?
  before_filter :tweets_by_month
  
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC')
    render :template => '/index'
  end
  
  private
  
  def tweets_by_month
    @tweets_by_month = Tweet.find(:all, :order => "posted_at DESC", :conditions => ["posted_at >= ?", 1.year.ago]).group_by { |tweet| tweet.posted_at.strftime("%B %Y")}
  end
  
  def need_scrapbook_update?
  	if File.exists?("#{Rails.root.to_s}/tmp/cache/scrapbook_cache")
  		if last_scrapbook_upate < 1.hour.ago
  			File.open("#{Rails.root.to_s}/tmp/cache/scrapbook_cache", "w+") {|f| f.write(Time.now)}
  			twitter_poll
  		end
  	else
  		File.open("#{Rails.root.to_s}/tmp/cache/scrapbook_cache", "w+") {|f| f.write(Time.now)}
  		twitter_poll
  	end
  end

  def last_scrapbook_upate
  	Time.parse(File.read("#{Rails.root.to_s}/tmp/cache/scrapbook_cache"))
  end

  def twitter_poll
  	for new_tweet in Twitter.user_timeline('GriffithStudio', {:include_rts => true, :include_entities => true})
  		store_tweet(new_tweet)
  	end
  end

  def store_tweet(data)
  	tweet = Tweet.create( :twitter_id => data.id, 
                          :raw_feed => data.instance_variable_get('@attrs').to_yaml,
                          :text => data.text, 
                          :is_retweet => (data.retweeted_status ? true : false),
                          :posted_at => data.created_at,
                          :media => pull_media(data),
                          :hashtags => pull_hashtags(data),
                          :mentions => pull_mentions(data),
                          :links => pull_links(data))
  end

  def pull_media(data)
    if data.instance_variable_get('@attrs')['entities']['media']
      media = []
      for entity in data.instance_variable_get('@attrs')['entities']['media'] do
        media_hash = Hash['source', entity['media_url'], 'display', entity['url'], 'type', entity['type']]
        media << media_hash.to_yaml
      end
      return media.join(",")
    else
      return nil
    end
  end

  def pull_links(data)
    if data.instance_variable_get('@attrs')['entities']['urls']
      links = []
      for link in data.instance_variable_get('@attrs')['entities']['urls'] do
        link_hash = Hash['source', link['expanded_url'], 'display', link['url']] 
        links << link_hash.to_yaml
      end
      return links.join(",")
    end
  end

  def pull_hashtags(data)
    if data.instance_variable_get('@attrs')['entities']['hashtags']
      hashtags = []
      for hashtag in data.instance_variable_get('@attrs')['entities']['hashtags'] do
        hashtags << "##{hashtag['text']}"
      end
      return hashtags.join(",")
    else
      return nil
    end
  end

  def pull_mentions(data)
    if data.instance_variable_get('@attrs')['entities']['user_mentions']
      mentions = []
      for mention in data.instance_variable_get('@attrs')['entities']['user_mentions'] do
        mentions << "#{mention['screen_name']}"
      end
      return mentions.join(",")
    else
      return nil
    end
  end
  
end
