require 'rails_helper'

RSpec.describe "recipes", type: :system do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

  describe "カスタム登録ページ" do
    before do
      login_for_system(user)
      visit new_recipe_path
    end

    context "ページレイアウト" do
      it "「カスタム登録」の文字列が存在すること" do
        expect(page).to have_content 'カスタム登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('カスタム登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'カスタム名'
        expect(page).to have_content '値段(Tall)'
        expect(page).to have_content '説明'
        expect(page).to have_content 'ベースドリンク'
        expect(page).to have_content 'おすすめ度 [1~5]'
      end
    end
  end
  
  describe "カスタム詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit recipe_path(recipe)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{recipe.name}")
      end

      it "カスタム情報が表示されること" do
        expect(page).to have_content recipe.name
        expect(page).to have_content recipe.price
        expect(page).to have_content recipe.description
        expect(page).to have_content recipe.drink
        expect(page).to have_content recipe.popularity
      end
    end
  end
end
