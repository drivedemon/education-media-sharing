class Category < ApplicationRecord
  has_many :contents, dependent: :destroy
  has_many :media_types, dependent: :destroy
  has_many :media_sub_types, dependent: :destroy
end
