module SearchModule
  extend ActiveSupport::Concern

  included do
    scope :desc_sort_create_at, -> {order(created_at: :desc)}
    scope :desc_limit, -> {order(limit: :desc)}
    scope :asc_priority, -> {order(priority: :asc)}
    scope :sort_title, -> (title){where('title LIKE ?', "%#{ title }%")}
    scope :sort_status, -> (status){where('status LIKE ?', "%#{ status }%")}
    scope :sort_title_and_status, -> (title,status){sort_title(title).sort_status(status)}
  end
end