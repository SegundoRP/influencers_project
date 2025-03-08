class CreateInfluencers < ActiveRecord::Migration[8.0]
  def change
    create_table :influencers do |t|
      t.string :external_id
      t.boolean :is_manual, null: false, default: true
      t.string :username, null: false
      t.string :fullname, null: false
      t.string :picture, null: false
      t.integer :followers, null: false
      t.boolean :is_verified, null: false
      t.integer :platform, null: false

      t.timestamps
    end

    add_index :influencers, %i[external_id platform], unique: true
    add_index :influencers, %i[username platform], unique: true
  end
end
