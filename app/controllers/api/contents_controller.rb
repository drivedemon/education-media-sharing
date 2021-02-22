class Api::ContentsController < Api::ApplicationController

  def index
    contents = Content.first
    # contents = Content.all.map(&:content_format)
# binding.pry
    render json: contents, status: :ok
  end

  def create
    content = Content.new(create_content_params)
    content.save
  rescue => e
    raise BadError.new(e)
  end

  private

  def create_content_params
    init_params = params.permit(
      :title,
      :description,
      :amount,
      :category_id,
      :media_type_id,
      :media_sub_type_id,
      :level,
      :resource,
      :content_file,
      :title_covers => [],
    )
    init_params.merge(
      {
        user_id: current_user&.id,
        status: :pending,
        level: init_params[:level]&.to_i,
        resource: init_params[:resource]&.to_i,
      }
    )
  end
end
