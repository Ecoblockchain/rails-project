class AddVerifierToSealsUsers < ActiveRecord::Migration
  def change
    add_column :seals_users, :verifier, :boolean
  end
end
