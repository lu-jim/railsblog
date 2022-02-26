class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :text
      t.integer :comment_counter
      t.integer :like_counter

      t.timestamps
    end
    add_reference :posts, :author, references: user, foreign_key: true
  end
end
