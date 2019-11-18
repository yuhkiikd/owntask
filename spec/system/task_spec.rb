require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'test_task'
        expect(page).to have_content 'test_A'
        expect(page).to have_content '未着手'
        expect(page).to have_content '2019-11-17'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順にならんでいること' do
        visit tasks_path
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'test_B'
        expect(task_list[2]).to have_content 'test_A'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: '成約マッチ'
        fill_in '優先度', with: 'test_Z'
        fill_in 'タスク詳細', with: 'test_details'
        find("option[value='未着手']").select_option
        select "未着手", from: "task_status"
        select "2020", from: "task_limit_1i"
        select "11", from: "task_limit_2i"
        select "30", from: "task_limit_3i"
        click_on '登録する'
        expect(page).to have_content '成約マッチ'
        expect(page).to have_content 'test_Z'
        expect(page).to have_content 'test_details'
        expect(page).to have_content '未着手'
        expect(page).to have_content '2020-11-30'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        task = FactoryBot.create(:task, 
                            id: 999,
                            title: '新規既存判定',
                            priority: 'test_B',
                            details: '新規既存データの判定',
                            status: '未着手',
                            limit: 'Sun, 17 Nov 2020')
        visit task_path(999)
        expect(page).to have_content '新規既存判定'
        expect(page).to have_content 'test_B'
        expect(page).to have_content '新規既存データの判定'
        expect(page).to have_content '未着手'
        expect(page).to have_content '2020-11-17'
      end
    end
  end
end