class Festival < ActiveRecord::Base
  has_and_belongs_to_many :bands
  attr_accessible :name
end
