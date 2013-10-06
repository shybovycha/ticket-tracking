class Ticket < ActiveRecord::Base
    has_and_belongs_to_many :users
    belongs_to :department
    has_many :comments

    validates :title, :presence => true
    validates :body, :presence => true, :length => { :minimum => 4 }
    validates :url_key, :presence => true, :format => /[A-Z]{3,}-\d+/i, :uniqueness => true

    scope :unassigned, -> { where(:assignee_id => nil) }
    scope :opened, -> { where(["status NOT IN (?)", [ :cancelled, :completed ]]) }
    scope :my, -> (email) { where(:assignee_id => User.find_by_email(email).id) }

    # validates :status, :inclusion => { :in => statuses_available }

    def assignee
        assignee_id = read_attribute(:assignee_id)

        if assignee_id.present?
            User.find(assignee_id)
        else
            nil
        end
    end

    def assignee=(user)
        write_attribute(:assignee_id, user.id)
    end

    def status
        (read_attribute :status).to_sym
    end

    def status=(value)
        (write_attribute :status, value.to_s)
    end

    def self.statuses_available
        [ :waiting_for_staff, :waiting_for_customer, :on_hold, :cancelled, :completed ]
    end

    def self.status_options_available
        [ 
            [ 'Waiting for staff', :waiting_for_staff ], 
            [ 'Waiting for customer', :waiting_for_customer ], 
            [ 'On hold', :on_hold ],
            [ 'Cancelled', :cancelled ],
            [ 'Completed', :completed ] 
        ]
    end

    def status_string
        (self.class.status_options_available.select { |s| s[1] == status.to_sym })[0][0]
    end

    def to_param
        url_key
    end
end
