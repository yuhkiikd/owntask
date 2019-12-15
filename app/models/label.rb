class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy, foreign_key: 'label_id'
  has_many :tasks, through: :labellings, source: :task

  belongs_to :user, optional: true
end