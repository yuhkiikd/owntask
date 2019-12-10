if Rails.env == "development"
  1.times do |i|
    User.create!(name: "admin", email: "admin@hoge.com", password: "hogehoge", admin: true)
  end

  10.times do |i|
    User.create!(name: "hoge#{i + 1}", email: "hoge#{i + 1}@hoge.com", password: "hogehoge")
  end
end 