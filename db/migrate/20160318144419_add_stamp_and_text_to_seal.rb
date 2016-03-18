class AddStampAndTextToSeal < ActiveRecord::Migration
  def change
    add_column :seals, :stamp, :string
    add_column :seals, :text, :string
  end
end
