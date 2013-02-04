class Rating < ActiveRecord::Base
  belongs_to :band
  belongs_to :user
  attr_accessible :rating, :band_id, :user_id
  validates :rating,
    :numericality => {
      :only_integer => true,
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 5
    },
    :presence => true
  validates :band, :presence => true
  validates :user, :presence => true
  after_save :after_save_callback

  def after_save_callback
    # Update average_rating in associated band
    self.band.average_rating = self.band.ratings.average(:rating)
    self.band.save
  end
end
