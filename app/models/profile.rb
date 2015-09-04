class Profile < ActiveRecord::Base
  # after_save :evaluate

  belongs_to :place
  belongs_to :report

  def title
    # TODO - Be more deliberate about handling titles
    # when we know it's not completed.
    "#{ report.try(:title) } in #{ place.try(:title) }"
  end

  # TODO
  # Make this a process object, with a complete! method
  # that completes things and sets the flags.
  def complete?
    place.present? && report.present?
  end

  def incomplete?
    !complete?
  end

  # def evaluated?
  #   evaluated
  # end

  # def not_yet_evaluated?
  #   !evaluated
  # end

  private

  # def evaluate
  #   update_attribute(:evaluation,
  #     ProfileEvaluator.new(place: place, report: report))
  # end

  # TODO:
  #  - Add evaluation:json, evaluated:boolean, evaluated_at:datetime
  #  - Add #evaluate method that returns a JSON evaluation of
  #    the profile and sets the status and timestamp.
  #    - The #evaluate method calls another object to do the evaluation work
end
