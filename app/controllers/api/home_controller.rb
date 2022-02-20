# frozen_string_literal: true

class Api::HomeController < ApplicationController
  def ping
    response = HatchwayPingApi.call
    render json: { success: response[:success] }
  end
end
