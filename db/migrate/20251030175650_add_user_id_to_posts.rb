class AddUserIdToPosts < ActiveRecord::Migration[7.1]
  def change
    # First add the column without the NOT NULL constraint
    add_reference :posts, :user, null: true, foreign_key: true

    # Create a default user if one doesn't exist and assign to existing posts
    reversible do |dir|
      dir.up do
        # Create a default user for existing posts
        default_user = User.find_or_create_by!(email: 'admin@example.com') do |user|
          user.password = 'password123'
          user.password_confirmation = 'password123'
        end

        # Assign all existing posts to this user
        Post.where(user_id: nil).update_all(user_id: default_user.id)
      end
    end

    # Now add the NOT NULL constraint
    change_column_null :posts, :user_id, false
  end
end
