class Api::List::MediaTypesController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: :index
  
  def index
    render json: MediaType.all, status: :ok
  end
end
