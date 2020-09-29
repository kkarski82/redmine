class CreateExtraIssuesJob < ApplicationJob
  queue_as :services

  def perform(args)
    create_issue(args)
  end

  protected

  def create_issue(args)
    ActiveRecord::Base.transaction do
      issue = Issue.create(args)

      raise ActiveRecord::Rollback if issue.has_problems?
    end

  rescue ActiveRecord::RecordInvalid
    Rails.logger(:error, 'There was a problem creating new issue')
  end
end
