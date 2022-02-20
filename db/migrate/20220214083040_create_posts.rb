class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :author
      t.integer :authorId
      t.integer :likes
      t.decimal :popularity
      t.integer :reads
      t.string :tags

      t.timestamps
    end
  end
end
