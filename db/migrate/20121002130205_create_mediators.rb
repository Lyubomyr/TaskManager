class CreateMediators < ActiveRecord::Migration
  def change
    create_table :mediators do |t|
      t.integer :user_id
      t.integer :task_id
    end
    add_index :mediators, :task_id
  end
end
