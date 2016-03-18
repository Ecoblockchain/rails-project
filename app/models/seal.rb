class Seal < ActiveRecord::Base
  has_many :seals_users
  has_many :users, through: :seals_users
end
