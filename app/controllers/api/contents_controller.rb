class Api::ContentsController < Api::ApplicationController
  skip_before_action :set_user_from_token, except: :create

  include FilterQuery

  def index
    contents = Content.joins(:category, :media_type, :media_sub_type, :user => :profile).all
    contents = filter_query(collections: contents, query: permitted_filter_params)
    contents = contents&.map(&:content_format)

    render json: contents, status: :ok
  end

  def create
    content = Content.new(create_content_params)

    if content.save
      render json: content.attributes, status: :ok
    else
      render json: content.errors, status: :bad_request
    end
  end

  def show
    content = Content.find(params[:id])&.content_format

    render json: content, status: :ok
  end

  private

  def permitted_filter_params
    params.permit(
      :media_type,
      :media_sub_type,
      :level,
      :resource,
    )
  end

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
