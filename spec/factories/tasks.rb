FactoryBot.define do
  factory :task do
    title { 'test_title' }
    details { 'test_details' }
    priority { 'A' }
    status { '未着手' }
    limit { 'Sun, 17 Nov 2019' }
  end
end