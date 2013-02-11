class Band < ActiveRecord::Base
  has_many :ratings
  has_and_belongs_to_many :festivals
  attr_accessible :description, :name, :location, :url
  validates :name, :presence => true

  def update_averate_rating
    self.average_rating = self.ratings.average(:rating)
    self.save
  end
end
