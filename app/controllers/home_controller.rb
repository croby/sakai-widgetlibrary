class HomeController < ApplicationController
  def index
    args = {
      :active => true
    }
    @recentlyadded = Widget.where(args).joins(:widget_versions).order("widget_versions.released_on desc").limit(5)
    @toprated = Widget.where(args).order("average_rating desc").limit(5)
    @mostpopular = Widget.where(args).order("random()").limit(16)
  end
end
