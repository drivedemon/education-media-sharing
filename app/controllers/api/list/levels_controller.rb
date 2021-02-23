class Api::List::LevelsController < Api::ApplicationController
  skip_before_action :set_user_from_token, only: :index

  def index
    levels = []
    Content.levels.map do |level, id|
      levels << {id: id, name: level}
    end
    render json: levels, status: :ok
  end
end
