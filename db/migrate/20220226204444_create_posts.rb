class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.text :title
      t.text :text
      t.integer :comment_counter
      t.integer :like_counter

      t.timestamps
    end
  end
end
