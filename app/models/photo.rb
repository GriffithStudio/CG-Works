class Photo < ActiveRecord::Base
  # t.integer :tweet_id, :null => false
  # add_column :photos, :image_file_name, :string
  # add_column :photos, :image_content_type, :string
  # add_column :photos, :image_file_size, :integer
  # add_column :photos, :image_updated_at, :datetime
  
  belongs_to :tweet
  
  has_attached_file :image, :styles => { :small => "150x150>", :medium => "300x300>", :large => "600x600>" },
                    :url  => "/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/photos/:id/:style/:basename.:extension"
  
end
