class DataPoint < ActiveRecord::Base

  belongs_to :aggregator
  belongs_to :topic
  has_and_belongs_to_many :data_collections
  has_and_belongs_to_many :reports

  validates :aggregator_id, presence: true

end
