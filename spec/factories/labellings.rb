FactoryBot.define do
  factory :labelling01, class: Labelling do
    label_id { 1 }
    task_id { 1 }
  end

  factory :labelling02, class: Labelling do
    label_id { 2 }
    task_id { 2 }
  end
end