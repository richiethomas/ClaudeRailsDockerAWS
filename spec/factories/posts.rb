FactoryBot.define do
  factory :post do
    association :user
    sequence(:title) { |n| "Post Title #{n}" }
    body { "This is the body content of the post. It contains multiple sentences to make it more realistic." }
    published { true }

    trait :draft do
      published { false }
    end

    trait :unpublished do
      published { false }
    end

    trait :with_comments do
      transient do
        comments_count { 3 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end
  end
end
