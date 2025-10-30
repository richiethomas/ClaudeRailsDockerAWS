module Comments
  class Comment < ApplicationRecord
    belongs_to :post, class_name: '::Post'
    belongs_to :user, class_name: '::User'

    validates :author, presence: true
    validates :body, presence: true
  end
end
