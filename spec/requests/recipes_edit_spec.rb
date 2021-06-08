require "rails_helper"

RSpec.describe "カスタム編集", type: :request do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること+フレンドリーフォワーディング" do
      get edit_recipe_path(recipe)
      login_for_request(user)
      expect(response).to redirect_to edit_recipe_url(recipe)
      patch recipe_path(recipe), params: { recipe: { name: "イカの塩焼き",
                                                     price: 300,
                                                     description: "冬に食べたくなる、身体が温まる料理です",
                                                     drink: "test",
                                                     popularity: 5 } }
      redirect_to recipe
      follow_redirect!
      expect(response).to render_template('recipes/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_recipe_path(recipe)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch recipe_path(recipe), params: { recipe: { name: "イカの塩焼き",
                                                     price: 300,
                                                     description: "冬に食べたくなる、身体が温まる料理です",
                                                     drink: "test",
                                                     popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    let!(:other_user) { create(:user) }

    it "ホーム画面にリダイレクトすること" do
      # 編集
      login_for_request(other_user)
      get edit_recipe_path(recipe)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch recipe_path(recipe), params: { recipe: { name: "イカの塩焼き",
                                                     price: "320",
                                                     description: "冬に食べたくなる、身体が温まる料理です",
                                                     drink: "aa",
                                                     popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
