require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:search_task_03)
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
        expect(task_list[1]).to have_content 'テストけんさく'
        expect(task_list[2]).to have_content 'test_B'
        expect(task_list[3]).to have_content 'test_A'
      end
    end
  end

  describe 'ソート・検索機能' do
    context '検索・ソート機能' do
      it 'タスクが終了期限の降順にソートできること' do
        visit tasks_path
        click_link '終了期限（降順）でソートする'
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content '2025-11-30'
        expect(task_list[2]).to have_content '2022-11-30'
        expect(task_list[3]).to have_content '2019-11-17'
      end

      it 'タスクが終了期限の降順にソートできること' do
        visit tasks_path
        click_link '優先順位（高）でソートする'
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'test_A'
        expect(task_list[2]).to have_content 'test_B'
        expect(task_list[3]).to have_content 'test_C'
      end

      it 'タイトルのみの検索結果が出ること' do
        visit tasks_path
        fill_in 'task[title]', with: 'test_task'
        click_on '検索'
        title = page.all('tr')
        expect(title[1]).to have_content 'test_task'
        expect(title[2]).not_to have_content 'テストけんさく'
      end

      it 'ステータスのみ検索結果に出ること' do
        visit tasks_path
        select '未着手', from: 'task[status]'
        click_on '検索'
        title = page.all('tr')
        expect(title[1]).to have_content '未着手'
        expect(title[2]).to have_content ''
      end

      it 'タイトル・ステータス共に検索して1件だけ結果が出ること' do
        visit tasks_path
        fill_in 'task[title]', with: 'task'
        click_on '検索'
        select '着手中', from: 'task[status]'
        click_on '検索'
        title = page.all('tr')
        expect(title[1]).to have_content 'test_task2', '着手中'
        expect(title[2]).to have_content ''
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