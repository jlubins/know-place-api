class Profile < ActiveRecord::Base
  before_save :evaluate!

  belongs_to :place
  belongs_to :report
  belongs_to :user

  def title
    # TODO - Be more deliberate about handling titles
    # when we know it's not completed.
    "#{ report.try(:title) } in #{ place.try(:title) }"
  end

  def self.complete
    where('place_id IS NOT NULL AND report_id IS NOT NULL')
  end

  # TODO
  # Make this a process object, with a complete! method
  # that completes things and sets the flags.
  def complete?
    place.present? && report.present?
  end
  alias_method :complete, :complete?

  def incomplete?
    !complete?
  end

  def evaluated?
    evaluated_at.presence
  end

  def not_yet_evaluated?
    !evaluated?
  end

  def evaluate!
    evaluate
  end

  private

  def evaluate
    if complete?
      assign_attributes(
        evaluation:   ProfileEvaluation.new(profile: self).perform,
        evaluated_at: Time.now
      )
    end
  end
end
