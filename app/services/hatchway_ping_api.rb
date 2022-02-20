# frozen_string_literal: true

class HatchwayPingApi < ApplicationService
  def initialize
    base_url
  end

  def call
    ping
  end

  private

  def ping
    result = RestClient.get(@base_url, headers = {})
  rescue RestClient::ExceptionWithResponse => e
    { success: false, error: e }
  else
    { success: result.code, payload: JSON.parse(result.body) }
  end

  def base_url
    @base_url = 'https://api.hatchways.io/assessment/blog/posts?tag=tech'
  end
end
