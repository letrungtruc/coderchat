class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :from_id
      t.integer :to_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
