class Post < ActiveRecord::Base
  belongs_to :festival
  attr_accessible :body, :title, :festival_id
end
