class AddTerminatorToSealsUsers < ActiveRecord::Migration
  def change
    add_column :seals_users, :terminator, :boolean
  end
end
