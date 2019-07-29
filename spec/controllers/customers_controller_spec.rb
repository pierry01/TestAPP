require 'rails_helper'
require 'devise'

RSpec.describe CustomersController, type: :controller do
  describe 'as a guest' do
    context '#index' do
      it '200 (successfully)' do
        get :index
        expect(response).to be_successful
      end
    end
    
    context '#show' do
      it '302 (not authorized)' do
        customer = create(:customer)
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end
    end
  end
  
  describe 'as a logged member' do
    context '#show' do
      it '200 (successfully)' do
        member = create(:member)
        customer = create(:customer)
        sign_in member
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(200)
      end
      
      it 'render a :show template' do
        member = create(:member)
        customer = create(:customer)
        sign_in member
        get :show, params: { id: customer.id }
        expect(response).to render_template(:show)
      end
    end
  end
end
