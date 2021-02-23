class Api::List::MediaSubTypesController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: :index
  
  def index
    render json: MediaSubType.all, status: :ok
  end
end
