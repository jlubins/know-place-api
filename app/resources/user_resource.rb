class UserResource < JSONAPI::Resource
  attributes :email

  has_many :places
  has_many :profiles

  def self.creatable_fields(context)
    super - [:token]
  end

  def self.updatable_fields(context)
    super - [:token]
  end

end
