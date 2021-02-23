class Api::List::ResourcesController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: :index

  def index
    resources = []
    Content.resources.map do |resource, id|
      resources << {id: id, name: resource}
    end
    render json: resources, status: :ok
  end
end
