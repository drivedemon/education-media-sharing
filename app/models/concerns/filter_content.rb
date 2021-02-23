require 'active_support/concern'

module FilterContent
  extend ActiveSupport::Concern

  included do
    scope :filter_by_media_type, -> (media_type) { where(media_type_id: media_type) }
    scope :filter_by_media_sub_type, -> (media_sub_type) { where(media_sub_type_id: media_sub_type) }
    scope :filter_by_level, -> (level) { where(level: level) }
    scope :filter_by_resource, -> (resource) { where(resource: resource) }
  end
end
