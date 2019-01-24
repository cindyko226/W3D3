# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

# MUST CALL CLASSNAME.ALL TO VIEW RECORDS
class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true

  belongs_to :submitter, {
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User 
  }

  
  def self.random_code(user, long_url)
    random_url = SecureRandom.urlsafe_base64(16,long_url)
    while self.exists?(random_url)
      random_url = SecureRandom.urlsafe_base64(16,long_url)
    end 
    ShortenedUrl.new(long_url: long_url, short_url: random_url, user_id: user.id)
  end 

end
