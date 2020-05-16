class Application < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :phone_number,
                        :description
end
