class Seal < ActiveRecord::Base
  has_many :seals_users
  has_many :owner_seals_users, -> {where owner: true}, class_name: 'SealsUser'
  has_many :terminator_seals_users, -> {where terminator: true}, class_name: 'SealsUser'
  has_many :verifier_seals_users, -> {where verifier: true}, class_name: 'SealsUser'
  has_many :users, through: :seals_users
  has_many :owners, through: :owner_seals_users, class_name: 'User', source: :user
  has_many :terminators, through: :terminator_seals_users, class_name: 'User', source: :user
  has_many :verifiers, through: :verifier_seals_users, class_name: 'User', source: :user
end
