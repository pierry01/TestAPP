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
    
    # context '#show' do
    #   it '302 (not authorized)' do
    #     customer = create(:customer)
    #     get :show, params: { id: customer.id }
    #     expect(response).to have_http_status(302)
    #   end
    # end
  end
  
  describe 'as a logged member' do
    before do
      @member = create(:member)
      @customer = create(:customer)
    end
    
    context '#show' do
      it '200 (successfully)' do
        sign_in @member
        get :show, params: { id: @customer.id }
        expect(response).to have_http_status(200)
      end
      
      it 'render a :show template' do
        sign_in @member
        get :show, params: { id: @customer.id }
        expect(response).to render_template(:show)
      end
    end
    
    context '#create' do
      it 'with valid attributes' do
        customer_params = attributes_for(:customer)
        sign_in @member
        expect { 
          post :create, params: { customer: customer_params }
        }.to change(Customer, :count).by(1)
      end
      
      it 'with invalid attributes' do
        customer_params = attributes_for(:customer, address: nil)
        sign_in @member
        expect { 
          post :create, params: { customer: customer_params }
        }.not_to change(Customer, :count)
      end
      
      it 'content_type JSON' do
        customer_params = attributes_for(:customer)
        sign_in @member
        post :create, format: :json, params: { customer: customer_params }
        expect(response.content_type).to eq('application/json')
      end
      
      it 'flash notice successfully' do
        customer_params = attributes_for(:customer)
        sign_in @member
        post :create, params: { customer: customer_params }
        expect(flash[:notice]).to match(/successfully/)
      end
    end

    context 'routes' do
      it { should route(:get, '/customers').to(action: :index) }
    end
  end
end
