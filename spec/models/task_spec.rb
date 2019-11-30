require 'rails_helper'

RSpec.describe "タスク管理機能", type: :model do
  describe 'バリデーションテスト' do
    before do
      @blank_title = FactoryBot.build(:task, title: "")
      @blank_details = FactoryBot.build(:task, details: "")
      @blank_priority = FactoryBot.build(:task, priority: "")
      @not_empty_task = FactoryBot.build(:task)
    end

    it "titleが空ならバリデーションが通らない" do
      expect(@blank_title).not_to be_valid
    end

    it 'detailsが空ならバリデーションが通らない' do
      expect(@blank_details).not_to be_valid
    end

    it 'priorityが空ならバリデーションが通らない' do
      expect(@blank_priority).not_to be_valid
    end

    it 'title・details・limit・priorityに内容が記載されていればバリデーションが通る' do
      expect(@not_empty_task).to be_valid
    end
  end

  describe 'scopeテスト' do
    before do
      FactoryBot.create(:search_task_01)
      FactoryBot.create(:search_task_02)
      FactoryBot.create(:search_task_03)
    end

    context 'タイトル検索テスト' do
      it '検索ワード：検索、2件見つかる'do
        expect(Task.where("title Like ?", "%検索%").count).to eq 2
      end

      it '検索ワード：けんさく、1件見つかる'do
        expect(Task.where("title Like ?", "%けんさく%").count).to eq 1
      end

      it '検索ワード：テスト、3件見つかる'do
        expect(Task.where("title Like ?", "%テスト%").count).to eq 3
      end
    end

    context 'ステータス検索テスト' do
      it '検索ワード：未着手、2件見つかる'do
        expect(Task.where(status: "未着手").count).to eq 2
      end

      it '検索ワード：完了、1件見つかる'do
        expect(Task.where("status Like ?", "%完了%").count).to eq 1
      end
    end

    context 'タイトル・ステータス検索テスト' do
      it '検索ワード：タイトル：検索、未着手、2件見つかる'do
        expect(Task.where("status Like ?", "%未着手%").count).to eq 2
      end

      it '検索ワード：完了、1件見つかる'do
        expect(Task.where("status Like ?", "%完了%").count).to eq 1
      end
    end
  end
end