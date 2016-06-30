class Team < ActiveRecord::Base
  
  include Searchable
  include Filterable
  include Sortable
  include Userstampable::Stampable
  include Userstampable::Stamper
  
  VALID_NAME_REGEX  = /[[:alpha:] \-]+/i
  
  has_ancestry
  
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
end
