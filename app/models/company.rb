# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  creator_id :integer
#  updater_id :integer
#  deleter_id :integer
#

class Company < ActiveRecord::Base
  
  include Searchable
  include Filterable
  include Sortable
  include Userstampable::Stampable
  include Userstampable::Stamper
  
  VALID_NAME_REGEX  = /[[:alpha:] \-]+/i
  
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
end
