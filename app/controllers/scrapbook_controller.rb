class ScrapbookController < ApplicationController
  
  def archives
    @archives = Tweet.find(:all, :order => "posted_at DESC").group_by { |tweet| tweet.posted_at.strftime("%B %Y")}
  end
  
  def archived_month
    @archived_month = Time.strptime(params[:archived_month], "%b-%Y")
    @tweets = Tweet.find(:all, :conditions => { :posted_at => @archived_month.beginning_of_month .. @archived_month.end_of_month }, :order => 'posted_at DESC')
  end
  
  def entry
    @tweet = Tweet.find_by_twitter_id(params[:id])
  end
  
end