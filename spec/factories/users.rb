FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    trait :with_posts do
      transient do
        posts_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |user, evaluator|
        posts = create_list(:post, 2, user: create(:user))
        evaluator.comments_count.times do
          create(:comment, user: user, post: posts.sample)
        end
      end
    end
  end
end
