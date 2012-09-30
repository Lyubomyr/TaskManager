class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :content
      t.integer :user_id
      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :created_at
  end
end
