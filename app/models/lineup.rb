class Lineup < ActiveRecord::Base
  belongs_to :band
  belongs_to :festival
  attr_accessible :band, :festival
end
