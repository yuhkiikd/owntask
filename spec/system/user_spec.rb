require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    FactoryBot.create(:user1)
    FactoryBot.create(:user2)
    FactoryBot.create(:user3)
  end

  def login
    visit new_session_path
    fill_in 'Email', with: 'test1@a.com'
    fill_in 'Password', with: 'hogehoge'
    click_on 'ログインする'
  end

  describe 'ユーザー登録テスト' do
    context 'ユーザー登録した場合' do
      it 'ユーザー登録後、自動でログインしてユーザーページに飛ぶ' do
        visit new_admin_user_path
        fill_in 'Name', with: 'test4'
        fill_in 'Email', with: 'test4@a.com'
        fill_in 'Password', with: 'hogehoge'
        fill_in 'Password confirmation', with: 'hogehoge'
        click_on 'アカウント新規作成'
        sleep 1
        expect(page).to have_content 'ようこそtest4さん'
        expect(page).to have_content 'ユーザーページ'
        expect(page).to have_content 'test4@a.com'
      end
    end

    context 'メールアドレスの重複登録をしようとした場合' do
      it '登録済みのメールアドレスは登録出来ない' do
        visit new_admin_user_path
        fill_in 'Name', with: 'test1'
        fill_in 'Email', with: 'test1@a.com'
        fill_in 'Password', with: 'hogehoge'
        fill_in 'Password confirmation', with: 'hogehoge'
        click_on 'アカウント新規作成'
        expect(page).to have_content 'Emailはすでに存在します'
      end
    end
  end

  describe 'ログイン・ログアウトテスト' do
    before do
      login
    end

    context 'ログイン後、ログアウトした場合' do
      it '自動でユーザーページへ飛び、ログイン成功のメッセージが出る' do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'test1@a.com'
      end

      it 'ログアウトしましたと表示される' do
        visit tasks_path
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '複数ユーザーテスト' do
    before do
      login
    end

    context 'ログイン後、別ユーザー詳細ページに飛んだ場合' do
      it 'indexページへリダイレクトされる' do
        visit admin_user_path(13)
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end