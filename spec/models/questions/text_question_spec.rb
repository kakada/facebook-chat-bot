require 'rails_helper'

RSpec.describe Questions::TextQuestion do
  context 'get' do
    let(:question) { create(:text_question) }

    let!(:fb_params) {
      {
        'message' => {
          'text' => question.label,
          'metadata' => 'DEVELOPER_DEFINED_METADATA'
        }
      }
    }

    it { expect(question.to_fb_params).to eq(fb_params) }
  end
end