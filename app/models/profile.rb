class Profile < ApplicationRecord
  belongs_to :user

  validates_presence_of :first_name, :last_name, :username

  enum gender: { male: 1, female: 2, other: 3 }, _prefix: true

  def profile_format
    slice(:username, :fullname)
  end

  def fullname
    "#{first_name} #{last_name}"
  end
end
