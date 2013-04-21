class PaymentType < ActiveRecord::Base
  attr_accessible :name
    has_many :sells

end
