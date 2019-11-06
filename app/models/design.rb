class Design < ApplicationRecord

  belongs_to :project

  has_attached_file :original_design, validate_media_type: false
  validates_attachment_content_type :original_design, content_type: /\Aimage\/.*\z/
  has_attached_file :processed_design, validate_media_type: false
  validates_attachment_content_type :processed_design, content_type: /\Aimage\/.*\z/

end
