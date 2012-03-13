include ActionDispatch::TestProcess

Factory.define :tweet do |f|
  f.twitter_id 1
  f.raw_feed "{feed}"
end