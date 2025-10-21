class Post < ApplicationRecord
  has_many :comments, class_name: "Comments::Comment", dependent: :destroy
end
