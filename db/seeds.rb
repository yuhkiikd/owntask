if Rails.env == "development"
  10.times do |i|
    User.create!(name: "hoge#{i + 1}", email: "hoge#{i + 1}@hoge.com", password_digest: "hogehoge")
  end
end 