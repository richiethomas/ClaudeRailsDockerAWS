class AddUserIdToCommentsComments < ActiveRecord::Migration[7.1]
  def change
    # First add the column without the NOT NULL constraint
    add_reference :comments_comments, :user, null: true, foreign_key: true

    # Assign existing comments to the default user
    reversible do |dir|
      dir.up do
        # Find the default user (created in previous migration)
        default_user = User.find_by!(email: 'admin@example.com')

        # Assign all existing comments to this user
        Comments::Comment.where(user_id: nil).update_all(user_id: default_user.id)
      end
    end

    # Now add the NOT NULL constraint
    change_column_null :comments_comments, :user_id, false
  end
end
