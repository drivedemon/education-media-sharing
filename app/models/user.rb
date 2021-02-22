class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :authentications, dependent: :destroy

  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: -> { new_record? || changes[:crypted_password] }
  validates_uniqueness_of :email, case_sensitive: true
end
