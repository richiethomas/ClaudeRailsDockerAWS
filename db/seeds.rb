# Clear existing data
puts "Clearing existing posts..."
Post.delete_all

# Create posts
puts "Creating posts..."

# Create 5 published posts
5.times do
  Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: rand(3..8)).join("\n\n"),
    published: true
  )
end

# Create 3 draft posts
3.times do
  Post.create!(
    title: Faker::Hacker.say_something_smart,
    body: Faker::Lorem.paragraphs(number: rand(2..5)).join("\n\n"),
    published: false
  )
end

# Create one featured post with lots of content
Post.create!(
  title: "Welcome to My Blog",
  published: true,
  body: <<~BODY
    #{Faker::Lorem.paragraph(sentence_count: 3)}

    ## Why I Started This Blog

    #{Faker::Lorem.paragraph(sentence_count: 5)}

    ## What You'll Find Here

    #{Faker::Lorem.paragraph(sentence_count: 4)}

    - #{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.noun}
    - #{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.noun}
    - #{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.noun}

    ## Looking Forward

    #{Faker::Lorem.paragraph(sentence_count: 6)}
  BODY
)

puts "Created #{Post.count} posts!"
puts "  - #{Post.where(published: true).count} published"
puts "  - #{Post.where(published: false).count} drafts"

# Create posts with varied timestamps
puts "Creating posts with varied dates..."

10.times do |i|
  Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: rand(3..8)).join("\n\n"),
    published: [true, true, false].sample, # 2/3 chance of published
    created_at: rand(30.days.ago..Time.now), # Random date in last 30 days
    updated_at: rand(7.days.ago..Time.now)   # Updated more recently
  )
end
