class Product < ApplicationRecord
  validates :avatar, presence: true
  validates :title, uniqueness: true, presence: true, length: { minimum: 10 }
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0.01 }

  has_attached_file :avatar, styles: { medium: "300x300>" }

  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/.png\Z/i, /.jpe?g\Z/i, /.gif\Z/i]
end
