# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  bot_id         :integer
#  type           :string(255)
#  select_name    :string(255)
#  name           :string(255)
#  label          :text
#  relevant_id    :integer
#  operator       :string(255)
#  relevant_value :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  media_image    :string(255)
#  description    :text
#  required       :boolean          default(FALSE)
#  uuid           :string(255)
#

class Question < ApplicationRecord
  include Questions::HtmlElementerizableConcern
  include Questions::FacebookParameterizableConcern

  belongs_to :bot
  belongs_to :relevant, class_name: 'Question', foreign_key: 'relevant_id'
  has_many :choices, dependent: :destroy
  has_many :respondents, foreign_key: :current_question_id, dependent: :nullify
  has_many :surveys, dependent: :nullify

  validates :name, uniqueness: { case_sensitive: false, scope: :bot_id }

  QUESTION_GET_STARTED = 'get_started'

  def self.types
    %w(Text Integer Decimal Date SelectOne SelectMultiple Note)
  end

  def kind
    raise 'You have to implemented in sub-class'
  end

  def value_of text
    text
  end

  def has_choices?
    choices.size > 0
  end

  def has_relevant?
    relevant.present?
  end

  def add_relevant(relevant)
    return unless relevant.present?

    relevant_field = relevant[/\$\{(\w+)\}/, 1]
    relevant_question = Question.find_by(bot_id: bot.id, name: relevant_field)
    relevant_value = relevant[/[‘|'|"](\w+)[’|'|"]/, 1]

    if relevant_question
      params = {
        relevant_id: relevant_question.id,
        operator: relevant[/(\>\=|\<\=|\!\=|[\+\-\*\>\<\=\|]|div|or|and|mod|selected)/, 1],
        relevant_value: relevant_question.value_of(relevant_value)
      }
      params[:operator] = '==' if params[:operator] == '='

      update_attributes(params)
    end
  end
end
