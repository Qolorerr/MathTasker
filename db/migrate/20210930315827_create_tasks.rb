class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :body
      t.string :answer, null: false
      t.references :creator, null: false, index: true, foreign_key: {to_table: :users}
      t.float :current_rating, default: 0, scale: 2

      t.timestamps
    end
  end
end