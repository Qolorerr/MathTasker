class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :nickname
      t.string :discription
      t.string :image
      t.string :completed_task_ids, default: ""

      t.timestamps
    end
  end
end
