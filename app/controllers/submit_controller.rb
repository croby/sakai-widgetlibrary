class SubmitController < ApplicationController
  def index
    @widget = Widget.new
    @widget.widget_version = WidgetVersion.new
    3.times { @widget.widget_version.screenshots.build }
  end

  def create
    @widget = Widget.new
    @widget[:user_id] = current_user[:id]
    @widget[:url_title] = params[:widget][:title].split(" ").collect!{|t| t.downcase}.join("-")
    @widget[:active] = false

    version = WidgetVersion.new(params[:widget])
    version[:state_id] = State.where(:title => "pending").first.id
    version[:widget_id] = @widget.id
    version.save

    @widget[:widget_version_id] = version.id
    @widget.save

    respond_to do |format|
      format.js
    end

  end

  def edit
    @widget = Widget.find(params[:widget_id])
  end

  def new_version
  end
end
