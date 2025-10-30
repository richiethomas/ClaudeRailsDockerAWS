FactoryBot.define do
  factory :comment, class: 'Comments::Comment' do
    association :user
    association :post
    sequence(:author) { |n| "Commenter #{n}" }
    body { "This is a comment body with some text content." }
  end
end
