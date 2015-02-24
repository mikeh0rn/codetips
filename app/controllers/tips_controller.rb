class TipsController < ApplicationController
  def index
    @tips = Tip.all
  end

  def show
    @tip = Tip.find(params[:id])
  end

  def new
  end

  def create
    @tip = Tip.new(tip_params)
    if @tip.save
      redirect_to @tip
    else
      render 'new'
    end
  end

  private
    def tip_params
      params.require(:tip).permit :language, :topic, :text
    end
end
