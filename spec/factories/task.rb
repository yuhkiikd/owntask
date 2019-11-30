FactoryBot.define do
  factory :task, class: Task do
    title { 'test_task' }
    details { 'test_details' }
    priority { 'test_A' }
    status { '未着手' }
    limit { 'Sun, 17 Nov 2019' }
  end

  factory :second_task, class: Task do
    title { 'test_task2' }
    details { 'test_details2' }
    priority { 'test_B' }
    status { '着手中' }
    limit { 'Sun, 30 Nov 2019' }
  end

  factory :search_task_01, class: Task do
    title { '検索テスト' }
    details { '検索テスト' }
    priority { 'test_C' }
    status { '未着手' }
    limit { 'Sun, 30 Nov 2020' }
  end

  factory :search_task_02, class: Task do
    title { 'テスト検索' }
    details { 'テスト検索' }
    priority { 'test_A' }
    status { '未着手' }
    limit { 'Sun, 30 Nov 2021' }
  end

  factory :search_task_03, class: Task do
    title { 'テストけんさく' }
    details { 'テストけんさく' }
    priority { 'test_B' }
    status { '完了' }
    limit { 'Sun, 30 Nov 2021' }
  end
end