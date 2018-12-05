require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let(:user) { create(:user) }
  # valid request object
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new(user.email, 'bar') }
  # invalid email
  subject(:invalid_auth_email) { described_class.new('foo', user.password) }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do 
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end

    context 'when invalid email' do
      it 'raises an not found error' do
        expect { invalid_auth_email.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /not found/
          )
      end
    end
  end
end
