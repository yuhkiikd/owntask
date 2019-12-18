FactoryBot.define do
  factory :task, class: Task do
    title { 'test_task' }
    details { 'test_details' }
    priority { 'A' }
    status { '未着手' }
    limit { 'Sun, 17 Nov 2019' }
    user_id { 10 }
  end

  factory :second_task, class: Task do
    title { 'test_task2' }
    details { 'test_details2' }
    priority { 'B' }
    status { '着手中' }
    limit { 'Sun, 30 Nov 2025' }
    user_id { 10 }
  end

  factory :search_task_01, class: Task do
    title { '検索テスト' }
    details { '検索テスト' }
    priority { 'C' }
    status { '未着手' }
    limit { 'Sun, 30 Nov 2020' }
    user_id { 20 }
  end

  factory :search_task_02, class: Task do
    title { 'テスト検索' }
    details { 'テスト検索' }
    priority { 'A' }
    status { '未着手' }
    limit { 'Sun, 30 Nov 2021' }
    user_id { 20 }
  end

  factory :search_task_03, class: Task do
    title { 'テストけんさく' }
    details { 'テストけんさく' }
    priority { 'C' }
    status { '完了' }
    limit { 'Sun, 30 Nov 2022' }
    user_id { 30 }
  end
end