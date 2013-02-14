class Festival < ActiveRecord::Base
  has_many :lineups
  has_many :bands, :through => :lineups, :uniq => true
  has_many :posts
  attr_accessible :name, :date, :location
  validates :name, :presence => true
  validates :date, :presence => true
end
