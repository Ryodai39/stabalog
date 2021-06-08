require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "ログの文字列が存在することを確認" do
        expect(page).to have_content 'スタバログ'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end
    end

    context "カスタムフィード", js: true do
        let!(:user) { create(:user) }
        let!(:recipe) { create(:recipe, user: user) }

        before do
          login_for_system(user)
        end

        it "カスタムのぺージネーションが表示されること" do
          login_for_system(user)
          create_list(:recipe, 6, user: user)
          visit root_path
          expect(page).to have_content "みんなのカスタム (#{user.recipes.count})"
          expect(page).to have_css "div.pagination"
          Recipe.take(5).each do |d|
            expect(page).to have_link d.name
          end
        end

        it "「新しいカスタムを作る」リンクが表示されること" do
         visit root_path
         expect(page).to have_link "新しいカスタムを作る", href: new_recipe_path
        end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "クックログとは？の文字列が存在することを確認" do
      expect(page).to have_content 'スタバログとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('スタバログとは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
