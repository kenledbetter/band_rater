class Band < ActiveRecord::Base
  has_many :ratings
  has_and_belongs_to_many :festivals
  attr_accessible :description, :name
  validates :name, :presence => true

  def average_rating
    #self.ratings.inject(0.0) {|sum, rating| sum
  end
end
