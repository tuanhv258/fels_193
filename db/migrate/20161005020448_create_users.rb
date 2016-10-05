class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :fullname
      t.string :avatar
      t.boolean :is_admin
      t.timestamps null: false
    end
  end
end
