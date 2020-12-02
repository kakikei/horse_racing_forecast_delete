class HorsesController < ApplicationController
  before_action :url_params, only: :access_site

  def index
    @horses = Horse.includes(:father, :mother).all
  end

  def access_site
    GetHorseInfoByJraJob.perform_later(params[:url])
    redirect_to root_path, notice: '取得中です'
  end

  private

  def url_params
    params.permit(:url)
  end
end
