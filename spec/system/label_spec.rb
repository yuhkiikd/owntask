require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
    FactoryBot.create(:user3)
    FactoryBot.create(:label01)
    FactoryBot.create(:label02)
    FactoryBot.create(:label03)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:search_task_03)
    FactoryBot.create(:labelling01)
    FactoryBot.create(:labelling02)
    FactoryBot.create(:labelling03)

    visit new_session_path
    fill_in 'Email', with: 'test1@a.com'
    fill_in 'Password', with: 'hogehoge'
    click_on 'ログインする'
  end

  describe 'ラベル登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データ保存後、タスク一覧に表示されること' do
        visit new_label_path
        fill_in 'label[label_type]', with: 'デバッグ'
        click_on('登録する')
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'デバッグ'
      end
      
      it '空白のラベルは作成できないこと' do
        visit new_label_path
        click_on('登録する')
        expect(page).to have_content 'ラベル名を入力してください'
      end
    end
  end

  describe 'タスク一覧・詳細画面' do
    context 'ラベル付タスクを作成した場合' do
      it 'タスク一覧にラベルが表示されること' do
        visit tasks_path
        expect(page).to have_content '会議'
        expect(page).to have_content 'リカバリー'
      end

      it 'タスク詳細にラベルが表示されること' do
        visit task_path(1)
        expect(page).to have_content '会議'
      end
    end
  end

  describe 'タスク作成画面' do
    context 'タスクを新規作成する場合' do
      it '他ユーザーのラベルは表示されないこと' do
        visit new_task_path
        task_list = page.all('tr')
        expect(page).to have_content '会議'
        expect(page).to have_content 'リカバリー'
        expect(page).not_to have_content '修正'
      end
    end
  end

  describe '検索機能' do
    context '検索機能' do
      it 'ラベルで絞り込み検索できること' do
        visit tasks_path
        select '会議', from: 'task[label_id]'
        click_on('検索')
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content '会議'
        expect(task_list[2]).not_to have_content 'リカバリー'
      end

      it '他ユーザーのラベル（タスク）が出てこないこと' do
        visit tasks_path
        select 'リカバリー', from: 'task[label_id]'
        click_on('検索')
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'リカバリー'
        expect(task_list[2]).not_to have_content '修正'
      end
    end
  end
end