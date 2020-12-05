require 'rails_helper'

RSpec.describe 'Contacts API' do
  let!(:list) { create(:list) }
  let!(:contacts) { create_list(:contact, 20, list_id: list.id) }
  let(:list_id) { list.id }
  let(:id) { contacts.first.id }

  # Test suite for GET /lists/:list_id/contacts
  describe 'GET /lists/:list_id/contacts' do
    before { get "/lists/#{list_id}/contacts" }

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

  # Test suite for GET /lists/:list_id/contacts/:id
  describe 'GET /lists/:list_id/contacts/:id' do
    before { get "/lists/#{list_id}/contacts/#{id}" }

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

  # Test suite for POST /lists/:list_id/contacts
  describe 'POST /lists/:list_id/contacts' do
    let(:valid_attributes) {{ name: 'Michael Scott', email: 'michaelscott@email.com' }}

    context 'when request attributes are valid' do
      before { post "/lists/#{list_id}/contacts", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/lists/#{list_id}/contacts", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /lists/:list_id/contact/:id
  describe 'PUT /lists/:list_id/contacts/:id' do
    let(:valid_attributes) {{ name: 'Michael Scott' }}

    before { put "/lists/#{list_id}/contacts/#{id}", params: valid_attributes }

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

  # Test suite for DELETE /lists/:list_id/contacts/:id
  describe 'DELETE /lists/:list_id/contacts/:id' do
    before { delete "/lists/#{list_id}/contacts/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end