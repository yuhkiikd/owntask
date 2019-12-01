require 'rails_helper'

RSpec.describe "タスク管理機能", type: :model do
  describe 'バリデーションテスト' do
    before do
      @blank_title = FactoryBot.build(:task, title: "")
      @blank_details = FactoryBot.build(:task, details: "")
      @blank_priority = FactoryBot.build(:task, priority: "")
      @blank_limit = FactoryBot.build(:task, limit: "")
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

    it 'limitが空ならバリデーションが通らない' do
      expect(@blank_limit).not_to be_valid
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
        expect(Task.sort_title("検索").count).to eq 2
      end

      it '検索ワード：けんさく、1件見つかる'do
        expect(Task.sort_title("けんさく").count).to eq 1
      end

      it '検索ワード：テスト、3件見つかる'do
        expect(Task.sort_title("テスト").count).to eq 3
      end
    end

    context 'ステータス検索テスト' do
      it '検索ワード：未着手、2件見つかる'do
        expect(Task.sort_status("未着手").count).to eq 2
      end

      it '検索ワード：完了、1件見つかる'do
        expect(Task.sort_status("完了").count).to eq 1
      end
    end

    context 'タイトル・ステータス検索テスト' do
      it '検索ワード：タイトル：検索、未着手、2件見つかる'do
        expect(Task.sort_title_and_status("検索", "未着手").count).to eq 2
      end

      it '検索ワード：タイトル：けんさく、ステータス：完了、1件見つかる' do
        expect(Task.sort_title_and_status("けんさく","完了").count).to eq 1
      end
    end

    context 'ソートテスト' do
      it '終了期限（降順）でソートすると2022が最初になる' do
        expect(Task.desc_limit[0].limit).to eq '2022-11-30'.to_date
      end

      it '優先順位（高）でソートするとAが最初になる' do
        expect(Task.asc_priority[0].priority).to eq 'test_A'
      end
    end
  end
end