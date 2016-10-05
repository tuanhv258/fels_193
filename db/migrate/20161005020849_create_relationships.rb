class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower
      t.integer :followed
      t.timestamps null: false
    end
  end
end
