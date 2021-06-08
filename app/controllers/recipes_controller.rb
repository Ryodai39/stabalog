class RecipesController < ApplicationController
    before_action :logged_in_user
    before_action :correct_user, only: [:edit, :update]

    def new
      @recipe = Recipe.new
    end

    def show
      @recipe = Recipe.find(params[:id])
    end

    def create
        @recipe = current_user.recipes.build(recipe_params)
        if @recipe.save
          flash[:success] = "カスタムが登録されました！"
          redirect_to recipe_path(@recipe)
        else
          render 'recipes/new'
        end
    end

    def edit
      @recipe = Recipe.find(params[:id])
    end

    def update
      @recipe = Recipe.find(params[:id])
      if @recipe.update_attributes(recipe_params)
        flash[:success] = "カスタムが更新されました！"
        redirect_to @recipe
      else
        render 'edit'
      end
    end

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user.admin? || current_user?(@recipe.user)
      @recipe.destroy
      flash[:success] = "カスタムが削除されました"
      redirect_to request.referrer == user_url(@recipe.user) ? user_url(@recipe.user) : root_url
    else
      flash[:danger] = "他人のカスタムは削除できません"
      redirect_to root_url
    end
  end
  private

      def recipe_params
          params.require(:recipe).permit(:name, :price, :description, :drink, :popularity)
      end

       def correct_user
         @recipe = current_user.recipes.find_by(id: params[:id])
         redirect_to root_url if @recipe.nil?
       end
end
