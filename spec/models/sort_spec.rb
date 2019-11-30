require 'rails_helper'

RSpec.describe "ソート機能", type: :model do

  it 'titleがnullならバリデーションエラー'
  it 'titleがnullならバリデーションエラー'
  it 'titleがnullならバリデーションエラー'
  it 'titleがnullならバリデーションエラー'
  it 'titleがnullならバリデーションエラー'
  it 'titleがnullならバリデーションエラー'

  before do
    FactoryBot.build(:task, title: "検索テストタイトル", details: "検索テスト詳細")
    FactoryBot.build(:second_task, title: "タイトルテスト検索", details: "詳細検索テスト")
  end

  describe '検索テスト' do
    context 'タイトル検索あり、ステータス検索なしの場合' do
      it '共通するタイトルが表示され、しないタイトルは表示されない' do
        visit root
        fill_in 'タイトル検索', with: '検索'
        select '', from: 'ステータス検索'
        click_on '検索'
        expect(page).to have_content '検索テストタイトル'
        expect(page).to have_content 'タイトルテスト検索'
      end
    end
  end
end