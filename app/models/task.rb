class Task < ApplicationRecord
  validates :title, presence: true
  validates :details, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :limit, presence: true
end