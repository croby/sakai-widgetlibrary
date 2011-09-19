class Widget < ActiveRecord::Base
  has_attached_file :icon, :styles => { :thumb => ["50x50!", :png], :medium => ["100x100!", :png], :large => ["800x800", :png] }
  has_attached_file :code

  belongs_to :state
  has_many :ratings
  has_many :screenshots
  has_many :screenshots, :dependent => :destroy
  accepts_nested_attributes_for :screenshots, :allow_destroy => true
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :languages

  attr_accessible :title, :description, :features, :screenshots_attributes, :code, :widget_repo, :widget_backend_repo, :icon, :category_ids, :language_ids

  # Validations
  validates_attachment_presence :icon
  validates_attachment_presence :code
  validates_attachment_content_type :code, :content_type => [ 'application/zip', 'application/x-zip', 'application/x-zip-compressed', 'application/octet-stream', 'application/x-compress', 'application/x-compressed', 'multipart/x-zip' ],
                                    :message => 'file must be a .zip file'
end
