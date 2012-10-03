class CreateSharings < ActiveRecord::Migration
  def change
    create_table :sharings do |t|
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
    add_index :sharings, :task_id
  end
end
