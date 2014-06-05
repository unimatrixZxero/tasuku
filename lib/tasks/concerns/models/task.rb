module Tasks::Concerns::Models::Task
  extend ActiveSupport::Concern

  included do
    belongs_to :taskable, polymorphic: true
    has_many   :responses, class_name: '::Tasks::Taskables::Taskable::Response'

    scope :completed_by,  ->(author) do
      joins(:responses).where(
        "tasks_taskables_taskable_responses.author_id = ? and
         tasks_taskables_taskable_responses.author_type = ?",
         author.id, author.class.name
       )
    end
    scope :incomplete_by, ->(author) { all.reject { |task| task.completed_by? author }}

    validates :taskable, presence: true

    delegate :completed_by?, :submissions, to: :taskable

    def to_s
      taskable.to_s
    end
  end
end
