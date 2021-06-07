class RecipesController < ApplicationController
    before_action :logged_in_user
    
    def new
      @recipe = Recipe.new
    end
end
