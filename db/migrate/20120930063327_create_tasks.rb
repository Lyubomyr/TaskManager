class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.timestamps
    end
    add_index :tasks, :created_at
  end
end
