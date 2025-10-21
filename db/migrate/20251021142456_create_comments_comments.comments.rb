# This migration comes from comments (originally 20251021141657)
class CreateCommentsComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments_comments do |t|
      t.integer :post_id
      t.string :author
      t.text :body

      t.timestamps
    end
  end
end
