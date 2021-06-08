require "rails_helper"

RSpec.describe "カスタムの削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

end