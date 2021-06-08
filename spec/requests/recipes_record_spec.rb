require "rails_helper"

RSpec.describe "カスタム登録", type: :request do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      get new_recipe_path
      login_for_request(user)
    end
    context "フレンドリーフォワーディング" do
     it "レスポンスが正常に表示されること" do
      expect(response).to redirect_to new_recipe_url
     end
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_recipe_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
