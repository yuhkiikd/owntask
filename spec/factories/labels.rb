FactoryBot.define do
  factory :label01, class: Label do
    id { 1 }
    label_type { '会議' }
    user_id { 10 }
  end

  factory :label02, class: Label do
    id { 2 }
    label_type { 'リカバリー' }
    user_id { 10 }
  end
end