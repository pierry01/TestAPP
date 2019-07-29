require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  it 'returns successfully' do
    get :index
    expect(response).to be_successful
  end
end
