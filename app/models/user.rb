class User < ActiveRecord::Base
  attr_accessible :name, :description, :email, :email_confirmation,
    :password, :password_confirmation, :as => [:default, :reviewer ,:admin]
  attr_accessible :reviewer, :admin, :featured, :as => :admin
  has_secure_password
  has_many :ratings
  has_many :posts
  validates_presence_of :name
  validates_presence_of :email
  validates_confirmation_of :email, :if => :email_changed?
  validates_presence_of :password, :on => :create
  default_scope order(:name)

  def role
    # Return current role admin > reviewer > default
    if self.admin
      return :admin
    elsif self.reviewer
      return :reviewer
    else
      return :default
    end
  end

  def is_admin?
    self.admin
  end

  def is_reviewer?
    self.admin || self.reviewer
  end
end
