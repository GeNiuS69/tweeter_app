class Comment < ActiveRecord::Base
  belongs_to :tweet, :counter_cache => true
  attr_accessible :message
end
