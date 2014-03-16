module Tasks
  class Taskables::Question::Answer < ActiveRecord::Base
    belongs_to :option
    belongs_to :author, polymorphic: true

    has_one :question, through: :option

    validates :option_id, presence: true
    validates :author_id, :author_type, presence: true

    validate :can_only_answer_each_question_once

    private

    def can_only_answer_each_question_once
      errors.add :base, I18n.t('tasks.taskables.questions.answers.already_answered') if question.answers.find_by author: author
    end
  end
end