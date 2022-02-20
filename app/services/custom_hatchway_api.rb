# frozen_string_literal: true

class CustomHatchwayApi < ApplicationService
  def initialize(tags, sort_by = nil, direction = 'asc')
    @tags = tags
    @sort_by = sort_by
    @direction = direction
    base_url
  end

  def call
    get_data
  end

  private

  def get_data
    final_result = { posts: '' }
    @tags.each do |tag|
      result = RestClient.get url(tag)
    rescue RestClient::ExceptionWithResponse => e
      { success: false, error: e }
    else
      final_result.merge!(JSON.parse(result.body)) { |_key, old_val, new_val| old_val + new_val }
    end

    { success: 'true', payload: final_result }
  end

  def url(tag, sort_by = nil, direction = 'asc')
    "#{@base_url}#{tag}&sortBy=#{sort_by}&direction=#{direction}"
  end

  def base_url
    @base_url = 'https://api.hatchways.io/assessment/blog/posts?tag='
  end
end
