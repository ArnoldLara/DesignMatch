class AddAttachmentOriginalDesignToDesigns < ActiveRecord::Migration[6.0]
  def self.up
    change_table :designs do |t|
      t.attachment :original_design
    end
  end

  def self.down
    remove_attachment :designs, :original_design
  end
end
