class Department < ActiveRecord::Base
    has_many :users

    validates :title, :presence => true
    validates :url_key, :presence => true, :format => /[A-Z]{3,}/i

    def url_key
        (read_attribute :url_key).upcase
    end

    def url_key=(value)
        write_attribute :url_key, value.upcase
    end
end
