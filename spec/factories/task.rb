FactoryBot.define do
  factory :task do
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
    status { '着手' }
    limit { 'Sun, 30 Nov 2019' }
  end
end