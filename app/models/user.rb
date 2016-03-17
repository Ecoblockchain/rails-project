class User < ActiveRecord::Base
  has_secure_password

  validates :name, length: { minimum: 3 }
  validates :password, length: { minimum: 5 }
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,
                                 message: "has to contain one number and one upper case letter"
                               }
end
