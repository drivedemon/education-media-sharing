class Api::List::MediaSubTypesController < Api::ApplicationController
  def index
    render json: MediaSubType.all, status: :ok
  end
end
