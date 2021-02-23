class MediaSubType < ApplicationRecord
  belongs_to :category
  has_many :contents, dependent: :destroy
end
