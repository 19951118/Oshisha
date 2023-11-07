class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,             null: false
      t.string :title,                null: false
      t.text :body
      t.integer :flavor_genre,        null: false
      t.integer :player,              null: false, default: 0
      t.string :location
      t.integer :hms_genre
      t.integer :top_genre
      t.integer :duration
      t.integer :price
      t.integer :flavor_capacity
      t.string :flavor_maker
      t.integer :smoking_level
      t.integer :smoking_taste_level
      t.boolean :bottle_option,       default: "false"
      t.boolean :nicotine,            default: "true"
      t.string :star,                 null: false
      t.timestamps
    end
  end
end
