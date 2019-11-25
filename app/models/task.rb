class Task < ApplicationRecord
  include SearchModule

  validates :title, presence: true
  validates :details, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :limit,  presence: true

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