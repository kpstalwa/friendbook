class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
 validates :content, presence: true
 has_many :likes
 has_many :comments
 mount_uploader :picture, PictureUploader
   validate  :picture_size

  # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
