class AddAttachmentProcessedDesignToDesigns < ActiveRecord::Migration[6.0]
  def self.up
    change_table :designs do |t|
      t.attachment :processed_design
    end
  end

  def self.down
    remove_attachment :designs, :processed_design
  end
end
