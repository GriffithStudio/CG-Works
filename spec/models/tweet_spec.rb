require 'spec_helper'

describe Tweet do
  
  it "validates the presence of the raw feed" do
    tweet = Tweet.new
    %w[raw_feed].each do |attr|
      tweet.should have(1).error_on(attr)
    end
  end
  
  it "validates the uniqueness of the twitter_id" do
    original_tweet = Factory.create(:tweet, :twitter_id => 1)
    duplicate_tweet = Factory.build(:tweet, :twitter_id => 1)
    duplicate_tweet.should have(1).error_on(:twitter_id)
  end
  
end
