class Category < ActiveRecord::Base
  has_and_belongs_to_many :widget_versions

  def widgets
    Widget.joins(:widget_version => :categories).where("categories_widget_versions.category_id = ?", self.id)
  end
  
end
