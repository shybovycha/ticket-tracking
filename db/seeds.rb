sales = Department.create :title => 'sales', :url_key => 'SALES'

sales_emails = [ 'jane@doe.yourcompany.com', 'will@smith.yourcompany.com', 'some@body.yourcompany.com' ]

sales_emails.each do |email|
    u = User.create :email => email, :password => 'abc123', :password_confirmation => 'abc123'
    sales.users << u
end

sales.save

developers = Department.create :title => 'developers', :url_key => 'DEV'

devs_emails = [ 'dev1@yourcompany.com', 'dev2@yourcompany.com' ]

devs_emails.each do |email|
    u = User.create :email => email, :password => 'abc123', :password_confirmation => 'abc123'
    developers.users << u
end

developers.save

ticket1 = Ticket.create :title => 'Myth #1',
                        :body => 'got no materials for creating a pineapple-bomb',
                        :status => :waiting_for_staff,
                        :reporter_email => 'my@email.com',
                        :reporter_name => 'Jammie Hannemann',
                        :url_key => 'DEV-1',
                        :department_id => sales.id

ticket1.users << sales.users.first
ticket1.users << developers.users.first

ticket1.save