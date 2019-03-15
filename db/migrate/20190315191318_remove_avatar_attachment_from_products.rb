class RemoveAvatarAttachmentFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :products, :avatar
  end
end
