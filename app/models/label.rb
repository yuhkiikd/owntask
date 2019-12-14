class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy, foreign_key: 'label_id'
  has_many :labelling_tasks, through: :labellings, source: :task
end