class Band < ActiveRecord::Base
  has_many :ratings
  has_many :lineups
  has_many :festivals, :through => :lineups, :uniq => true
  attr_accessible :description, :name, :location, :url, :popularity
  validates :name, :presence => true

  def update_averate_rating
    self.average_rating = self.ratings.average(:rating)
    self.save
  end
end
