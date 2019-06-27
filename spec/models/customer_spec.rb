require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :customers
  
  it 'Create a Customer' do
    customer = customers(:jean)
    
    expect(customer.full_name).to eq('Sr. Jean')
  end
end
