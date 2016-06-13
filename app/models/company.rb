class Company < ActiveRecord::Base
  
  include Searchable
  include Filterable
  include Sortable
  include Userstampable::Stampable
  include Userstampable::Stamper
  
end
