class SealsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :seal
end
