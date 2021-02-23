require 'active_support/concern'

module FilterQuery
  extend ActiveSupport::Concern

  private

  def filter_query(collections)
    permitted_filter_params.each do |key, value|
      next unless value.present?
      collections = collections.public_send("filter_by_#{key}", value)
    end
    collections
  end
end
