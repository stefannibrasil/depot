class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_one_attached :image, :dependent => :restrict_with_error
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, uniqueness: true, presence: true, length: { minimum: 10 }
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0.01 }
  validate :image_format
  validate :image_size
  
  private

    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end

    def image_format
      if image.attached? && !image.attachment.blob.content_type.in?(%w(image/png image/jpeg image/jpg))
        errors.add(:image, ' must be an image file')
        image.purge
        throw :abort
      end
    end

    def image_size
      if image.attached? && image.blob.byte_size > 5000000
        errors.add(:image, ' is too big')
        image.purge
        throw :abort
      end
    end
end
