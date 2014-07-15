class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO: temporary accessors, so that the gem won't break when accessing them
  attr_accessor :name
  def admin?
    true
  end
end
