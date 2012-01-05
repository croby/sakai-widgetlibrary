class ApplicationController < ActionController::Base
  protect_from_forgery
  WillPaginate.per_page = 16

  helper_method :is_admin?, :can_view_admin_area?

  def search
    @searchresults = Widget.joins(:widget_version).where("widgets.active = ? AND widget_versions.title LIKE '%#{params[:q]}%'", true).order("widget_versions.created_at DESC")
    render :partial => 'core/searchresults'
  end

  $version_sorts = ["title"]

  def get_sort(default = "average_rating desc")
    ret = default
    if params[:s] && params[:d]
      if $version_sorts.include?(params[:s])
        ret = "widget_versions.#{params[:s]} #{params[:d]}"
      else
        ret = "#{params[:s]} #{params[:d]}"
      end
    end
    ret
  end

  def can_view_admin_area?
    user_signed_in? && ( current_user.admin || current_user.reviewer )
  end

  def is_admin?
    user_signed_in? && current_user.admin
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
