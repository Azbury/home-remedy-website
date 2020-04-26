class CategoriesController < ApplicationController
    #list of all categories
    def index
        @categories = Category.all
    end

    #category show page
    def show
        @category = Category.find(params[:id])
    end
end