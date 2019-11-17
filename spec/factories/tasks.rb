FactoryBot.define do
  factory :task do
    title { 'test_title' }
    details { 'test_details' }
    priority { 'test_priority' }
    status { 'test_status' }
    limit { 'test_limit' }
  end
end