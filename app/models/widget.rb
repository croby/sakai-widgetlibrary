class Widget < ActiveRecord::Base

  belongs_to :user
  has_many :ratings
  belongs_to :widget_version
  has_many :widget_versions
  has_many :screenshots

  accepts_nested_attributes_for :widget_versions, :screenshots, :allow_destroy => true

  attr_accessible :url_title

  validates_uniqueness_of :url_title

  def self.find_by_state(state_title, order = "released_on desc", page = 1, userid = nil)
    filterstate = State.where(:title => state_title).first
    conditions = {:state_id => filterstate.id}
    if userid
      conditions[:user_id] = userid
    end
    WidgetVersion.where(conditions).joins(:widget).order(order).page(page)
  end

  def self.count_by_state(state_id, userid = nil)
    conditions = {:state_id => state_id}
    if userid
      conditions[:user_id] = userid
    end
    Widget.count(:conditions => conditions)
  end

  def approved_versions
    WidgetVersion.where(:state_id => State.accepted, :widget_id => self.id)
  end

  # I'm sure there is a better way to do this. For now, we'll just do a pass-through here
  def title
    self.widget_version.title
  end

  def description
    self.widget_version.description
  end

  def features
    self.widget_version.features
  end

  def icon
    self.widget_version.icon
  end

  def code
    self.widget_version.code
  end

  def state
    self.widget_version.state
  end

  def code_file_name
    self.widget_version.code_file_name
  end

  def code_content_type
    self.widget_version.code_content_type
  end

  def code_file_size
    self.widget_version.code_file_size
  end

  def code_updated_at
    self.widget_version.code_updated_at
  end

  def categories
    self.widget_version.categories
  end

  def languages
    self.widget_version.languages
  end

  def screenshots
    self.widget_version.screenshots
  end

  def version_number
    self.widget_version.version_number
  end

  def version_number_title
    self.widget_version.version_number_title
  end

  def widget_repo
    self.widget_version.widget_repo
  end

  def widget_backend_repo
    self.widget_version.widget_backend_repo
  end

  def released_on
    self.widget_version.released_on
  end

  def approved_by
    self.widget_version.approved_by
  end

end
