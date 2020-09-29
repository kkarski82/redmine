class CreateExtraIssuesJob < ApplicationJob
  queue_as :services

  def perform(args)
    create_issue(args)
  end

  protected

  def create_issue(args)
    Issue.new(args)
  end
end
