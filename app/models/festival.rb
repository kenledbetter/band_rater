class Festival < ActiveRecord::Base
  has_many :lineups
  has_many :bands, :through => :lineups, :uniq => true
  attr_accessible :name, :date
end
