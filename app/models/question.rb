require 'expressions/or_expression'
require 'expressions/and_expression'
require 'condition'

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

  serialize :relevants

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

  def has_relevants?
    relevants.present?
  end

  def matched? user_response, relevant
    operator = ComparativeOperator::OPERATORS[relevant.operator]
    eval("'#{user_response.value}' #{operator} '#{value_of(relevant.value)}'")
  end

end
