class LegislatorsController < ApplicationController
  before_action :set_legislator, only: [:show]
  before_action :set_favorited_ids
  before_action :authenticate_user!, only: [:favorite]

  def index
    set_legislators
  end

  def show
  end

  def search
    state_slug = params[:state_or_chamber]
    @state = find_by_state_slug(state_slug)
    set_legislators(@state)
    render :index
  end

  def search_by_location
    if params[:search].present?
      set_legislators_by_location
    end
  end

  def favorites
    set_favorite_legislators
  end

  private

  def order_params
    {
      chamber: :desc,
      state: :asc,
      state_rank: :desc,
      district: :asc
    }
  end

  def set_legislators(state = nil)
    legislators = Legislator.order(order_params)

    legislators = legislators.where(state: state) unless state.nil?
    @legislators = legislators.page(params[:page])
  end

  def set_favorite_legislators
    @legislators = current_user.legislators.order(order_params)
      .page(params[:page])
  end

  def set_legislators_by_location
    @search = params[:search]
    bioguide_ids = CongressApiService.search_by_address(@search)
    @legislators = Legislator.where(bioguide_id: bioguide_ids)
      .order(order_params).page(params[:page])
  end

  def set_favorited_ids
    return unless user_signed_in?
    @favorited_ids = current_user.legislators.ids
  end

  def set_legislator
    @legislator = Legislator.includes(:sponsorships, :cosponsorships).find(params[:id])
  end

  def find_by_state_slug(state_slug)
    state = States::STATES_AND_TERRITORIES.find do |key, value|
      value.gsub('.', '').parameterize == state_slug
    end

    state.try(:first)
  end
end
