class Task < ApplicationRecord
  include SearchModule

  validates :title, presence: true
  validates :details, presence: true
  validates :priority, inclusion: { in: %w(A B C D E) }, presence: true
  validates :status, inclusion: { in: %w(未着手 着手中 完了) }, presence: true
  validates :limit, presence: true
end