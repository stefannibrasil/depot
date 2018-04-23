class Product < ApplicationRecord
  has_attached_file :avatar, styles: {
                              medium: "300x300>",
                              thumb: "100x100>"
                            }

  validates_attachment :avatar, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
