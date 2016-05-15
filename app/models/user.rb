class User < ActiveRecord::Base
  has_secure_password

  has_many :seals_users
  has_many :owned_seals_users, -> {where owner: true}, class_name: 'SealsUser'
  has_many :terminable_seals_users, -> {where terminator: true}, class_name: 'SealsUser'
  has_many :verifiable_seals_users, -> {where verifier: true}, class_name: 'SealsUser'
  has_many :seals, through: :seals_users
  has_many :owned_seals, through: :owned_seals_users,
           class_name: 'Seal', source: :seal
  has_many :terminable_seals, through: :terminable_seals_users,
           class_name: 'Seal', source: :seal
  has_many :verifiable_seals, through: :verifiable_seals_users,
           class_name: 'Seal', source: :seal


  validates :name, length: { minimum: 3 }
  validates :password, length: { minimum: 5 }
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,
                                 message: "has to contain one number and one upper case letter"
                               }
end
