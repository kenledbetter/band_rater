class User < ActiveRecord::Base
  attr_accessible :name, :description, :email, :email_confirmation,
    :password, :password_confirmation
  has_secure_password
  has_many :ratings
  validates_presence_of :name
  validates_presence_of :email
  validates_confirmation_of :email
  validates_presence_of :password, :on => :create
end
