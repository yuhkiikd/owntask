module SearchModule
  extend ActiveSupport::Concern

  included do
    scope :desc_sort_create_at, -> {order(created_at: :desc)}
    scope :desc_limit, -> {order(limit: :desc)}
    scope :asc_priority, -> {order(priority: :asc)}
    scope :sort_title, -> (title){where('title LIKE ?', "%#{ title }%")}
    scope :sort_status, -> (status){where('status LIKE ?', "%#{ status }%")}
    scope :sort_title_and_status, -> (title,status){sort_title(title).sort_status(status)}

    def self.set_sort(params)
      if params[:sort_limit_desc]
        desc_limit
      elsif params[:asc_priority]
        asc_priority
      elsif params[:task].present?
        if params[:task][:title].present? && params[:task][:status].present?
          sort_title_and_status(params[:task][:title],params[:task][:status])
        elsif params[:task][:status].present?
          sort_status(params[:task][:status])
        elsif params[:task][:title].present?
          sort_title(params[:task][:title])
        else
          desc_sort_create_at
        end
      else
        desc_sort_create_at
      end
    end
  end
end