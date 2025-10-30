class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: "Comments::Comment", dependent: :destroy
end
