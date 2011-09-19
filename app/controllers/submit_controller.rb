class SubmitController < ApplicationController
  def index
    @widget = Widget.new
    3.times { @widget.screenshots.build }
    puts @widget.screenshots.inspect
  end

  def create
    @widget = Widget.new(params[:widget])
    if @widget.save
      redirect_to @widget, notice: 'Widget was successfully created.'
    else
      format.json { render json: @widget.errors, status: :unprocessable_entity }
    end
  end

  def edit
  end
end
