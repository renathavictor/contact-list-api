require 'rails_helper'

RSpec.describe 'Contacts API' do
  let(:user) { create(:user) }
  let!(:list) { create(:list, created_by: user.id) }
  let!(:contacts) { create_list(:contact, 20, list_id: list.id) }
  let(:list_id) { list.id }
  let(:id) { contacts.first.id }
  let(:headers) { valid_headers }

  describe 'GET /lists/:list_id/contacts' do
    before { get "/lists/#{list_id}/contacts", params: {}, headers: headers }

    context 'when list exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all list contacts' do
        expect(json.size).to eq(20)
      end
    end

    context 'when list does not exist' do
      let(:list_id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find List/)
      end
    end
  end

  describe 'GET /lists/:list_id/contacts/:id' do
    before { get "/lists/#{list_id}/contacts/#{id}", params: {}, headers: headers }

    context 'when list contact exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the contact' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when list contact does not exist' do
      let(:id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Contact/)
      end
    end
  end

  describe 'POST /lists/:list_id/contacts' do
    let(:valid_attributes) { { name: 'Michael Scott', email: 'michaelscott@email.com' }.to_json }

    context 'when request attributes are valid' do
      before { post "/lists/#{list_id}/contacts", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/lists/#{list_id}/contacts", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /lists/:list_id/contacts/:id' do
    let(:valid_attributes) { { name: 'Michael Scott' }.to_json }

    before { put "/lists/#{list_id}/contacts/#{id}", params: valid_attributes, headers: headers }

    context 'when contact exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the contact' do
        update_contact = Contact.find(id)
        expect(update_contact.name).to match(/Michael Scott/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Contact/)
      end
    end
  end

  describe 'DELETE /lists/:list_id/contacts/:id' do
    before { delete "/lists/#{list_id}/contacts/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end