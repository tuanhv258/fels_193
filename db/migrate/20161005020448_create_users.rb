class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :fullname
      t.string :avatar
      t.boolean :is_admin, default :false
      t.timestamps null: false
    end
  end
end
