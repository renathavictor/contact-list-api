require 'rails_helper'

RSpec.describe 'Lists API', type: :request do
  let!(:lists) { create_list(:list, 10) }
  let(:list_id) { lists.first.id }

  # Test suite for GET /lists
  describe 'GET /lists' do
    before { get '/lists' }

    it 'return lists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /lists/:id' do
    before { get "/lists/#{list_id}" }

    context 'when the record exists' do
      it 'returns the list' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(list_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:list_id) { 100 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end

  # Test suite for POST /lists
  describe 'POST /lists' do
    let(:valid_attributes) {{ title: 'Work Friends', created_by: '1' }}

    context 'when the request is valid' do
      before { post '/lists', params: valid_attributes }

      it 'creates a list' do
        expect(json['title']).to eq('Work Friends')
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/lists', params: { title: 'Home' } }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /lists/id
  describe 'PUT /lists/:id' do
    let(:valid_attributes) {{ title: 'Party Friends' }}

    context 'when the record exists' do
      before { put "/lists/#{list_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #  Test suite for DELETE /lists/:id
  describe 'DELETE /lists/:id' do
    before { delete "/lists/#{list_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end