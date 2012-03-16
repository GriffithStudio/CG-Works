class AdminController < ApplicationController
  
  http_basic_authenticate_with(:name => APP_CONFIG['admin_username'], :password => APP_CONFIG['admin_password'], :realm => APP_CONFIG['admin_realm']) if !Rails.env.development?
  
  skip_before_filter :tweets_by_month
  
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC')
  end
  
  def update_scrapbook_display
    tweet = Tweet.find(params[:tweet])
    tweet.display ? tweet.display = false : tweet.display = true
    tweet.save!
    render :nothing => true
  end
  
  def refresh_all_tweets
    twitter_poll
    redirect_to admin_path
  end
  
  def refresh_tweet
    repoll_tweet(params[:tweet])
    redirect_to admin_path(:anchor => "#entry_#{params[:tweet]}")
  end
  
  private
  
  def repoll_tweet(twitter_id)
    current_tweet = Tweet.find_by_twitter_id(twitter_id)
    new_data = Twitter.status(twitter_id, {:include_rts => true, :include_entities => true})
    current_tweet.photos.destroy_all
    current_tweet.update_attributes(  
                          :raw_feed => new_data.instance_variable_get('@attrs').to_yaml,
                          :text => new_data.text, 
                          :is_retweet => (new_data.retweeted_status ? true : false),
                          :posted_at => new_data.created_at,
                          :media => pull_media(new_data),
                          :hashtags => pull_hashtags(new_data),
                          :mentions => pull_mentions(new_data),
                          :links => pull_links(new_data))
  end
  
end