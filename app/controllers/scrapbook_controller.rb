class ScrapbookController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  skip_before_filter :tweets_by_month, :only => [:archives]
  
  def archives
    @subtitle = "Archives"
    @archives = Tweet.find(:all, :conditions => {:display => true}, :order => "posted_at DESC").group_by { |tweet| tweet.posted_at.strftime("%B %Y")}
  end
  
  def archived_month
    @archived_month = Time.strptime(params[:archived_month], "%b-%Y")
    @subtitle = @archived_month.strftime("%B %Y")
    @tweets = Tweet.find(:all, :conditions => { :display => true, :posted_at => @archived_month.beginning_of_month .. @archived_month.end_of_month }, :order => 'posted_at DESC')
  end
  
  def entry
    @tweet = Tweet.find_by_twitter_id(params[:id])
    @subtitle = truncate(@tweet.text.gsub(/((http:\/\/)([A-Za-z0-9_=%&@\?\.\/\-]+))\b/,''), :length => 50)
  end
  
end