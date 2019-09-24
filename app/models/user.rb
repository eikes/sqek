class User < ApplicationRecord

  ROLES = { 'Admin' => 'admin', 'User' => 'user' }

  validates :role, inclusion: { in: ROLES.values }

  has_and_belongs_to_many :cities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  # Removed default modules:
  # :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

end
