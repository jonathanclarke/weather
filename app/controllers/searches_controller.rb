class SearchesController < ApplicationController

  def new
    @search = Search.new
    @results = Search.order("created_at desc").page params[:page]
  end

  def create
    @search_params = Search.new(search_params)
    @search = Search.pull_weather_data(@search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to root_path, :notice => "Success!" }
      else
        format.html { render action: "new" }
      end
    end
  end

  private
    def search_params
      params.require(:search).permit(:zipcode)
    end

end
