require 'rails_helper'

RSpec.describe "タスク管理機能", type: :model do
  before do
    @blank_title = FactoryBot.build(:task, title: "")
    @blank_details = FactoryBot.build(:task, details: "")
    @not_empty_task = FactoryBot.build(:task)
  end

  it "titleが空ならバリデーションが通らない" do
    expect(@blank_title).not_to be_valid
  end

  it 'detailsが空ならバリデーションが通らない' do
    expect(@blank_details).not_to be_valid
  end

  it 'titleとdetailsに内容が記載されていればバリデーションが通る' do
    expect(@not_empty_task).to be_valid
  end
end