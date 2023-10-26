require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #home' do
    context 'when user is signed in' do
      before do
        sign_in create(:user) 
        get :home
      end

      it 'redirects to articles path' do
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'when user is not signed in' do
      before do
        get :home
      end

      it 'redirects to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #search' do
    let(:user) { create(:user) }
    before { sign_in user }

    context 'when articles are found' do
      before do
        allow(Article).to receive(:search).and_return([create(:article)])
        
        get :search, params: { query: 'test' }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns articles in the response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["articles"].size).to eq(1)
      end
    end

    context 'when no articles are found' do
      before do
        allow(Article).to receive(:search).and_return([])
        
        get :search, params: { query: 'nonexistent' }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns no articles in the response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["articles"]).to be_empty
      end
    end
  end
end