class DataPoint < ActiveRecord::Base

  has_one :aggregator
  has_and_belongs_to_many :fields

  validates :aggregator_id, presence: true
  validates :field_mapping, presence: true

  has_and_belongs_to_many :data_collections
  has_and_belongs_to_many :reports

  #  This doesn't belong in the model, but rather in a
  #  custom validator.
  # TODO COMPLETE THESE
  # validate  :field_mapping_structure
  # validate  :field_mapping_has_related_fields

  #  validates that field_mapping is the right structure and that
  #  it only has field ids to which it is related

  alias_attribute :fmap, :field_mapping

  private

  def field_mapping_structure
    vals = fmap.map {|f| f["field_id"].presence && f["param"].presence }
    if vals.uniq.include? false
      errors.add :field_mapping,
        "each mapping must contain keys :field_id and :param"
    end
  end

  def field_mapping_has_related_fields
    vals = fmap.map {|f| self.fields.pluck(:id).include? field_id}
    if vals.uniq.include? false
      errors.add :field_mapping,
        "must only contain IDs of related fields"
    end
  end


end