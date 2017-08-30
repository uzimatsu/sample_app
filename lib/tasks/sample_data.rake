namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships

  end

  def make_users
    User.create!(name: "Example User",
    email: "example@railstutorial.jp",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true)

    User.create!(name: "炭治郎",
    email: "kimetu@kamaboko1.jp",
    password: "opt01opt",
    password_confirmation: "opt01opt",
    admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password)
    end
  end

  def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content)}
    end
  end

  def make_relationships
    users = User.all
    user = users.second
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end
end