module Comments
  class Comment < ApplicationRecord
    belongs_to :post, class_name: '::Post'

    validates :author, presence: true
    validates :body, presence: true
  end
end
