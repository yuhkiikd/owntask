require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2, admin: true)
    FactoryBot.create(:user3)
    FactoryBot.create(:task, user_id: 10)
    FactoryBot.create(:second_task, user_id: 20)
  end

  def login
    visit new_session_path
    fill_in 'Email', with: 'test1@a.com'
    fill_in 'Password', with: 'hogehoge'
    click_on 'ログインする'
  end

  def login_admin
    visit new_session_path
    fill_in 'Email', with: 'test2@a.com'
    fill_in 'Password', with: 'hogehoge'
    click_on 'ログインする'
  end

  describe 'ユーザー登録テスト' do
    context 'ユーザー登録した場合' do
      it '自動でログインしてユーザーページに飛ぶ' do
        visit new_user_path
        fill_in 'Name', with: 'test4'
        fill_in 'Email', with: 'test4@a.com'
        fill_in 'Password', with: 'hogehoge'
        fill_in 'Password confirmation', with: 'hogehoge'
        click_on '登録する'
        sleep 1
        expect(page).to have_content 'test4さんのアカウントを作成しました'
        expect(page).to have_content 'ユーザーページ'
        expect(page).to have_content 'test4@a.com'
      end
    end

    context 'メールアドレスの重複登録をしようとした場合' do
      it '登録済みのメールアドレスは登録出来ない' do
        visit new_user_path
        fill_in 'Name', with: 'test1'
        fill_in 'Email', with: 'test1@a.com'
        fill_in 'Password', with: 'hogehoge'
        fill_in 'Password confirmation', with: 'hogehoge'
        click_on '登録する'
        expect(page).to have_content 'Emailはすでに存在します'
      end
    end
  end

  describe 'ログイン・ログアウト時テスト' do
    before do
      login_admin
    end

    context 'ログイン後、ログアウトした場合' do
      it '自動でユーザーページへ飛び、ログイン成功のメッセージが出る' do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'test2@a.com'
      end

      it 'ログアウトしましたと表示される' do
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end

    context 'ログアウト状態でタスクページに飛ぼうとした場合' do
      it 'ログインページへ繊維する' do
        click_on 'ログアウト'
        visit tasks_path
        expect(page).to have_content 'ログインページ'
      end
    end

    context 'ログイン状態でユーザー登録画面へ遷移した場合' do
      it 'タスク一覧画面へ遷移する' do
        visit new_session_path
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '複数ユーザーテスト' do
    before do
      login
    end

    context 'ログイン後、別ユーザー詳細ページに飛んだ場合' do
      it 'indexページへリダイレクトされる' do
        visit user_path(13)
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '管理者権限テスト' do
    before do
      login_admin
    end

    context '管理者権限でログインした場合' do
      it 'ユーザー管理画面に遷移できる' do
        click_on "ユーザー管理"
        expect(page).to have_content "管理画面のユーザー一覧"
      end

      it 'ユーザー情報の更新ができる' do
        visit edit_admin_user_path(10)
        select "管理者", from: 'user[admin]'
        fill_in 'user[password]', with: "hogehoge"
        fill_in 'user[password_confirmation]', with: "hogehoge"
        click_on "更新する"
        expect(page).to have_content "ユーザー【 test1 】の更新をしました"
      end

      it '管理者自身のアカウント削除は出来ない' do
        visit admin_users_path
        page.all('td')[9].click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "管理者自身は削除できません"
      end
    end

    context '管理者が一人しかいない状態で権限の変更をした場合' do
      it '権限の変更はできない' do
        visit edit_admin_user_path(20)
        select "一般", from: 'user[admin]'
        fill_in 'user[password]', with: "hogehoge"
        fill_in 'user[password_confirmation]', with: "hogehoge"
        click_on "更新する"
        visit admin_user_path(20)
        expect(page).to have_content "管理者"
      end
      
      it 'エラーメッセージが出る' do
        visit edit_admin_user_path(20)
        select "一般", from: 'user[admin]'
        fill_in 'user[password]', with: "hogehoge"
        fill_in 'user[password_confirmation]', with: "hogehoge"
        click_on "更新する"
        expect(page).to have_content "ユーザー【 test2 】の権限以外を更新しました　※管理者は最低一人必要です"
      end
    end
  end

  describe '一般権限テスト' do
    before do
      login
    end

    context '一般権限でログインした場合' do
      it 'ユーザー管理画面には遷移できず、エラーメッセージが出る' do
        visit admin_users_path
        expect(page).to have_content '管理者権限がありません'
        expect(page).to have_content 'タスク一覧'
        visit edit_admin_user_path(20)
        expect(page).to have_content '管理者権限がありません'
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end