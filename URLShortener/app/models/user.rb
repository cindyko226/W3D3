# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validate :valid_email?

  def valid_email?
    if !email.include?('@')
      errors[:email] << "INVALID EMAIL!!!!"
    end
  end

  has_many :submitted_urls, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl
  }


end
