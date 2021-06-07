require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:recipe_yesterday) { create(:recipe, :yesterday) }  # 追記
  let!(:recipe_one_week_ago) { create(:recipe, :one_week_ago) }  # 追記
  let!(:recipe_one_month_ago) { create(:recipe, :one_month_ago) } 
  let!(:recipe) { create(:recipe) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(recipe).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      recipe = build(:recipe, name: nil)
      recipe.valid?
      expect(recipe.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      recipe = build(:recipe, name: "あ" * 31)
      recipe.valid?
      expect(recipe.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      recipe = build(:recipe, description: "あ" * 141)
      recipe.valid?
      expect(recipe.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      recipe = build(:recipe, user_id: nil)
      recipe.valid?
      expect(recipe.errors[:user_id]).to include("を入力してください")
    end

    it "人気度が1以上でなければ無効な状態であること" do
      recipe = build(:recipe, popularity: 0)
      recipe.valid?
      expect(recipe.errors[:popularity]).to include("は1以上の値にしてください")
    end

    it "人気度が5以下でなければ無効な状態であること" do
      recipe = build(:recipe, popularity: 6)
      recipe.valid?
      expect(recipe.errors[:popularity]).to include("は5以下の値にしてください")
    end
  end
  
  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(recipe).to eq Recipe.first
    end
  end
  
end
