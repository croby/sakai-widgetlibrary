class MywidgetsController < ApplicationController
  before_filter :authenticated
  layout 'lhnavigation'

  def index
    order = get_sort

    @widgets = Widget.where(:user_id => current_user.id, :active => true).order(order).page(params[:page])
    @count = Widget.count(:conditions => {:user_id => current_user.id})

    if request.xhr?
      render :partial => "pagewidgets/widget_list"
    end
  end

  def submissions
    @widgets = Widget.where(:user_id => current_user.id).includes(:versions).order("versions.created_at desc, versions.reviewed_on desc")
  end

  def authenticated
    if !user_signed_in?
      redirect_to :root
    end
  end

end
