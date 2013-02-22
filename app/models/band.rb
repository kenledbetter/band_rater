class Band < ActiveRecord::Base
  has_many :ratings, :dependent => :destroy
  has_many :lineups, :dependent => :destroy
  has_many :festivals, :through => :lineups, :uniq => true
  attr_accessible :description, :name, :location, :url, :popularity
  validates :name, :presence => true
  default_scope order("average_rating desc")

  def update_averate_rating
    self.average_rating = self.ratings.average(:rating)
    self.save
  end
end
