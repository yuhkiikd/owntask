class Task < ApplicationRecord
  include SearchModule

  validates :title, presence: true
  validates :details, presence: true
  validates :priority, inclusion: { in: %w(A B C D E) }, presence: true
  validates :status, inclusion: { in: %w(未着手 着手中 完了) }, presence: true
  validates :limit, presence: true
  validates :labellings, presence: true

  belongs_to :user, foreign_key: "user_id"

  has_many :labellings, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :labellings, source: :label

  accepts_nested_attributes_for :labellings
end