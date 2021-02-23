class Api::List::CategoriesController < Api::ApplicationController
  def index
    render json: Category.all, status: :ok
  end
end
