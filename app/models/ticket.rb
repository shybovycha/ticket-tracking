class Ticket < ActiveRecord::Base
    has_and_belongs_to_many :users

    validates :title, :presence => true
    validates :body, :presence => true, :length => { :minimum => 4 }
    validates :url_key, :presence => true, :format => /[A-Z]{3,}-\d+/i, :uniqueness => true

    # validates :status, :inclusion => { :in => statuses_available }

    def status
        (read_attribute :status).to_sym
    end

    def status=(value)
        (write_attribute :status, value.to_s)
    end

    def self.statuses_available
        [ :waiting_for_staff, :waiting_for_customer, :on_hold, :cancelled, :completed ]
    end
end
