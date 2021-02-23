class Api::List::CategoriesController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: :index

  def index
    render json: Category.all, status: :ok
  end
end
