class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update]

  # GET /users/1/invitations
  # GET /users/1/invitations.json
  def indexbyuser
    begin
      @event_ids = []
      @user = User.find(params[:user_id])
      @invitations = @user.invitations.all
      for @invitation in @invitations
        @event_ids << @invitation.event_id
      end
      @events = Event.find(@event_ids)
      rescue
        head 403
    end
  end
  
  # GET /events/1/invitations
  # GET /events/1/invitations.json
  def indexbyevent
    begin
    @user_ids = []
    @event = Event.find(params[:event_id])
    @invitations = @event.invitations.all
    #@user_ids = @invitaions.map{|invitation| invitaion.user_id}
    for @invitation in @invitations
      @user_ids << @invitation.user_id
    end
    @users = User.find(@user_ids)
    rescue
      head 403
    end

  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def newf
    begin
      @event = Event.find(params[:event_id])
    rescue
      head 403
    end
    @invitation = @event.invitations.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    begin
      @event = Event.find(params[:event_id])
    rescue
      head 403
    end
    print "invitaion_params print: "
    print invitation_params
    @invitation = @event.invitations.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to user_event_invitations_path(@user,@event), notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    begin
      @invitation = Invitation.find(params[:id]);
    rescue
      head 403
    end
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    begin
      @invitation = Invitation.find(params[:id]);
    rescue
      head 200
    end
    if( @invitation != nil)
      @invitation.destroy
    end
    respond_to do |format|
      format.html { redirect_to user_event_invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      begin
        @invitation = Invitation.find(params[:id])
      rescue
        head 403
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:user_id, :event_id, :response)
    end
end
