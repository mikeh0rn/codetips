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

  def edit
    @tip = Tip.find(params[:id])
  end

  def update
    @tip = Tip.find(params[:id])
      if @tip.update_attributes(tip_params)
        redirect_to tips_path
      else
        render 'edit'
      end
  end

  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy
    redirect_to tips_path
  end



  private
    def tip_params
      params.require(:tip).permit :language, :topic, :text
    end
end
