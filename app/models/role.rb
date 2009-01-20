class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates_uniqueness_of :role_name
  validate :is_non_standard
  
  RADIANT_STANDARDS = ['admin', 'developer']
  
  def is_non_standard
    if RADIANT_STANDARDS.include?(self[:role_name].to_s)
      self.errors.add :role_name, "may not be any of: #{RADIANT_STANDARDS.join(', ')}"
    end
  end
end
