class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @tips = []
    else
      @tips = Tip.search(params[:q])
    end
  end
end