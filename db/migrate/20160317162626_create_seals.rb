class CreateSeals < ActiveRecord::Migration
  def change
    create_table :seals do |t|

      t.timestamps null: false
    end
  end
end
