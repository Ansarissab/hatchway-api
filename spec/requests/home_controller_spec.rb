require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /api/ping' do
    it 'returns success response' do
      get '/api/ping'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/posts' do
    it 'return error that tags is required' do
      get '/api/posts?'
      expect(JSON.parse(response.body)).to eq({ 'error' => 'tags parameter required.' })
    end

    it 'return error that sortBy is required' do
      get '/api/posts?tags=tech'
      expect(JSON.parse(response.body)).to eq({ 'error' => 'sort by parameter is invalid.' })
    end

    it 'return error that direction is required' do
      get '/api/posts?tags=tech&sortBy=likes'
      expect(JSON.parse(response.body)).to eq({ 'error' => 'direction parameter is invalid.' })
    end

    it 'returns correct response' do
      get '/api/posts?tags=tech,health&sortBy=likes&direction=asc'

      expect(JSON.parse(response.body)['posts'].first).to eq({ 'author' => 'Rylee Paul', 'authorId' => 9,
                                                               'id' => 1, 'likes' => 960, 'popularity' => 0.13, 'reads' => 50_361, 'tags' => %w[tech health] })
    end

    it 'returns correct response' do
      get '/api/posts?tags=health,tech&sortBy=likes&direction=asc'

      expect(JSON.parse(response.body)['posts'].first).to eq({ 'author' => 'Rylee Paul', 'authorId' => 9,
                                                               'id' => 1, 'likes' => 960, 'popularity' => 0.13, 'reads' => 50_361, 'tags' => %w[tech health] })
    end
  end
end
