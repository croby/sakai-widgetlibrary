class WidgetController < ApplicationController
  def show
    widget_title = params[:widget_title]
    @widget = Widget.first( :conditions => { :url_title => widget_title } )
    latest_version = @widget.approved_versions.order("version_number desc").limit(1).first

    # if there is a new version and you're an admin
    # if @widget.version > latest_version.version_number
    # end

    if latest_version
      puts "latest version"
    elsif !can_view_admin_area? && (!@widget.widget_version.state_id.eql?(State.accepted) && @widget.user != current_user)
      not_found
    end
    @versions = @widget.approved_versions.order("version_number desc")
    @related = Widget.where(:active => true).order("random()").limit(5)
  end

  def new

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def create

  end
end
