# frozen_string_literal: true

class Api::HomeController < ApplicationController
  before_action :verify_tags_parameter, only: %i[posts]
  before_action :verify_sort_parameter, only: %i[posts]
  before_action :verify_direction_parameter, only: %i[posts]

  def ping
    response = HatchwayPingApi.call
    render json: { success: response[:success] }
  end

  def posts
    tags = params[:tags].split(',')
    response = CustomHatchwayApi.call(tags)
    render json: { success: response }
  end

  private

  def verify_tags_parameter
    render json: { error: 'tags parameter required.' } unless params[:tags].present?
  end

  def verify_direction_parameter
    render json: { error: 'direction parameter is invalid.' } unless params[:direction].present? && params[:direction].in?(%w[
                                                                                                                             desc asc
                                                                                                                           ])
  end

  def verify_sort_parameter
    render json: { error: 'sort by parameter is invalid.' } unless params[:sortBy].present? && params[:sortBy].in?(%w[
                                                                                                                     id reads likes popularity
                                                                                                                   ])
  end
end
