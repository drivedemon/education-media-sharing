class Api::List::MediaTypesController < Api::ApplicationController
  def index
    render json: MediaType.all, status: :ok
  end
end
