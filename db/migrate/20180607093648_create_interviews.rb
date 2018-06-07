class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.datetime :date
      t.integer :status
      t.timestamps
    end
  end
end
