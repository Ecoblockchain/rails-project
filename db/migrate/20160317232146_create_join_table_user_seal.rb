class CreateJoinTableUserSeal < ActiveRecord::Migration
  def change
    create_join_table :users, :seals do |t|
      t.index [:user_id, :seal_id]
    end
  end
end
