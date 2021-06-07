class RecipesController < ApplicationController
    before_action :logged_in_user
    
    def new
      @recipe = Recipe.new
    end
    
    def create
        @recipe = current_user.recipes.build(recipe_params)
        if @recipe.save
          flash[:success] = "カスタムが登録されました！"
          redirect_to root_url
        else
          render 'recipes/new'
        end
    end
    
    private
    
      def recipe_params
          params.require(:recipe).permit(:name, :price, :description, :drink, :popularity)
      end
end