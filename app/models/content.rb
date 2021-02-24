class Content < ApplicationRecord
  include Rails.application.routes.url_helpers
  include FilterContent

  has_many_attached :title_covers, dependent: :destroy
  has_one_attached :content_file, dependent: :destroy

  belongs_to :user
  belongs_to :category
  belongs_to :media_type
  belongs_to :media_sub_type

  validates_presence_of :title, :description, :amount, :category_id, :media_type_id, :media_sub_type_id, :level, :resource
  validate :title_cover_validation, :content_file_validation

  enum level: {
    initial: 0,
    grade_1: 1,
    grade_2: 2,
    grade_3: 3,
    grade_4: 4,
    grade_5: 5,
    grade_6: 6,
    grade_7: 7,
    grade_8: 8,
    other: 9
  }, _prefix: true
  enum resource: { music_theory: 1, assignment: 2, cord: 3, scale: 4 }, _prefix: true
  enum status: { pending: 1, approved: 2, rejected: 3 }, _prefix: true

  def content_format
    slice(:id, :title, :description, :amount, :level, :resource, :status).merge(
      {
        category: category&.name,
        media_type: media_type&.name,
        media_sub_type: media_sub_type&.name,
        created_user: user&.profile&.profile_format,
        content_file: content_file.service_url,
        title_covers: title_covers.to_a.map{|title_cover| {cover_path: title_cover.service_url}}
      }
    )
  end

  private

  def title_cover_validation
    if title_covers.attached?
      if title_covers.blobs.pluck(:byte_size).detect{|e| e > 1000000}
        errors[:title_covers] << 'Too big'
      elsif title_covers.blobs.size > 3
        errors[:title_covers] << 'Maximum 3 file'
      end
    else
      errors[:title_covers] << 'Title cover can not null'
    end
  end

  def content_file_validation
    if content_file.attached?
      if content_file.blob.byte_size > 100000000
        content_file.purge
        errors[:content_file] << 'Too big'
      end
    else
      errors[:content_file] << 'Title cover can not null'
    end
  end
end
