class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    begin
      @user = User.find(params[:user_id])
      @events = @user.events.all
    rescue
      head 403
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
     @event = Event.find(params[:id])
     @user = User.find(@event.user_id)
  end

  # GET /events/new
  def new
    begin
      @user = User.find(params[:user_id])
    rescue
      head 403
    end
    @event = @user.events.new
  end

  # GET /events/1/edit
  def edit
    #@user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @user = User.find(params[:user_id])
    @event = @user.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path(@user), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    begin
      @event = Event.find(params[:id]);
    rescue 
      head 403
    end
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to user_events_path(@user), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    begin
      @event = Event.find(params[:id]);
      @event.destroy
      status 200
    rescue
      head 200
    end
    respond_to do |format|
      format.html { redirect_to user_events_url, notice: 'Event was successfully destroyed.' }
      format.json {head :ok}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def set_event
    end
    def event_params
      params.require(:event).permit(:name, :description, :location, :start_time, :end_time, :user_id)
    end
  end
