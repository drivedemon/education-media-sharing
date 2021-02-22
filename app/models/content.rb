class Content < ApplicationRecord
  has_many_attached :title_covers, dependent: :destroy
  has_one_attached :content_file, dependent: :destroy

  belongs_to :user
  belongs_to :category

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
  enum resource: {
    music_theory: 1,
    assignment: 2,
    cord: 3,
    scale: 4
  }, _prefix: true
  enum status: { pending: 1, approved: 2, rejected: 3 }, _prefix: true

  def content_format
    slice(:id, :title, :description, :amount, :category, :level, :resource, :status).merge(
      {
        # title_covers_path: title_covers.map{|e| url_for(e)}
        # content_file: content_file
      }
    )
  end
end
