class Post < ActiveRecord::Base
  belongs_to :festival
  belongs_to :user
  attr_accessible :body, :title, :publish, :festival_id, :user_id
end
