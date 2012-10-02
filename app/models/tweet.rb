class Tweet < ActiveRecord::Base
  attr_accessible :message, :counter, :likes
  has_many :comments
  validates :message, :presence => true, :length => {:maximum => 140}
end
