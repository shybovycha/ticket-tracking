class TicketsController < ApplicationController
    before_action :set_ticket, only: [:show, :edit, :update, :destroy, :take_ownership]
    before_action :check_authentication, :only => [:index, :edit, :update, :destroy]

    # GET /tickets
    def index
        @tickets = case params[:filter]
            when 'closed' then Ticket.closed
            when 'on_hold' then Ticket.on_hold
            when 'open' then Ticket.open
            when 'unassigned' then Ticket.unassigned
            when 'my' then Ticket.my(current_user.email)
            else Ticket.all
        end
    end

    # GET /tickets/ABC-123
    def show
        if user_signed_in?
            @comment = Comment.new
        end
    end

    # GET /tickets/new
    def new
        @ticket = Ticket.new
    end

    # GET /tickets/ABC-123/edit
    def edit
    end

    def take_ownership
        @ticket.assignee = current_user
        @ticket.save

        redirect_to @ticket
    end

    # POST /tickets
    def create
        department = Department.find_by_url_key(params[:department])

        @ticket = department.tickets.new(ticket_params)

        @ticket.url_key = "#{ department.url_key }-#{ department.tickets.count + 1 }"
        @ticket.status = :waiting_for_staff

        NotificationMailer.ticket_submit_email(@ticket).deliver

        if @ticket.save
            redirect_to @ticket, notice: 'Ticket was successfully created.'
        else
            render action: 'new'
        end
    end

    # PATCH/PUT /tickets/ABC-123
    def update
        if @ticket.update(ticket_params)
            redirect_to @ticket, notice: 'Ticket was successfully updated.'
        else
            render action: 'edit'
        end
    end

    # DELETE /tickets/ABC-123
    def destroy
        @ticket.destroy
        redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
    end

    private
        def check_authentication
            redirect_to '/', :flash => { :error => "You should be logged in for seeing this!" } unless user_signed_in?
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_ticket
            @ticket = Ticket.find_by_url_key(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def ticket_params
            params.require(:ticket).permit(:title, :body, :department, :reporter_name, :reporter_email, :assignee_id, :status)
        end
end
