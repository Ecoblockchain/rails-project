class User < ActiveRecord::Base
  has_secure_password

  has_many :seals_users
  has_many :seals, through: :seals_users

  validates :name, length: { minimum: 3 }
  validates :password, length: { minimum: 5 }
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,
                                 message: "has to contain one number and one upper case letter"
                               }
end
