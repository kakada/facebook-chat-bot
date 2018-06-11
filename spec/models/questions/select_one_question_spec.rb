require 'rails_helper'

RSpec.describe Questions::SelectOneQuestion do
  context 'get' do
    let!(:bot) { create(:bot) }
    let!(:question) { create(:select_one_question) }
    let!(:choice) { create(:choice, question: question) }

    let!(:fb_params) {
      {
        'message' => {
          'attachment' => {
            'type' => 'template',
            'payload' => {
              'template_type' => 'button',
              'text' => question.label,
              'buttons' => [
                {
                  'type' => 'postback',
                  'title' => 'label',
                  'payload' => 'choice'
                }
              ]
            }
          }
        }
      }
    }

    it { expect(question.to_fb_params).to eq(fb_params) }
  end
end
