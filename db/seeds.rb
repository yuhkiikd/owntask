if Rails.env == "development"
  1.times do |i|
    User.create!(name: "admin", email: "admin@hoge.com", password: "hogehoge", admin: true)
  end

  10.times do |i|
    User.create!(name: "hoge#{i + 1}", email: "hoge#{i + 1}@hoge.com", password: "hogehoge")
  end

  10.times do |i|
    Task.create!(title: "テスト#{i + 1}",
                details: "テスト詳細#{i + 1}",
                priority: "A",
                status: "未着手",
                limit: "Sun, #{i + 1} Nov 2020",
                user_id: 1
                )
  end

  10.times do |i|
    Task.create!(title: "テスト#{i + 10}",
                details: "テスト詳細#{i + 10}",
                priority: "A",
                status: "着手中",
                limit: "Sun, #{i + 1} Nov 2020",
                user_id: 1
                )
  end

  10.times do |i|
    Task.create!(title: "テスト#{i + 20}",
                details: "テスト詳細#{i + 20}",
                priority: "C",
                status: "完了",
                limit: "Sun, #{i + 20} Nov 2020",
                user_id: 1
                )
  end

  1.times do |i|
    Label.create!(label_type: "設計")
    Label.create!(label_type: "企画")
    Label.create!(label_type: "準備")
    Label.create!(label_type: "営業")
    Label.create!(label_type: "販売")
    Label.create!(label_type: "実行")
    Label.create!(label_type: "打合せ")
    Label.create!(label_type: "リカバリー")
    Label.create!(label_type: "会議")
    Label.create!(label_type: "その他")
  end

  10.times do |i|
    Labelling.create!(task_id:"#{i + 1}", label_id:1)
    Labelling.create!(task_id:"#{i + 10}", label_id:2)
    Labelling.create!(task_id:"#{i + 20}", label_id:3)
  end
end 