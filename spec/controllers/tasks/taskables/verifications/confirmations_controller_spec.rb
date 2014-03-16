require 'spec_helper'

module Tasks
  describe Taskables::Verifications::ConfirmationsController do
    routes { Tasks::Engine.routes }

    describe "POST 'create'" do
      it 'routes' do
        expect(post: '/verifications/1/confirmations').to route_to(
          action: 'create',
          controller: 'tasks/taskables/verifications/confirmations',
          verification_id: '1'
        )
      end

      context 'with a confirmation' do
        let(:user)         { create :user }
        let(:verification) { create :verification }

        before do
          request.env['HTTP_REFERER'] = 'http://example.org'

          post :create, verification_id: verification.id, taskables_verification_confirmation: {
            author_type: user.class.name,
            author_id: user.id
          }
        end

        it 'should redirect' do
          expect(response).to be_redirect
        end

        it 'creates a new confirmation' do
        end
      end
    end

  end
end