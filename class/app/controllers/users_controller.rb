class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def createBulk
    @i = 1
    @total_events = 0
    @total_users = (params[:count]).to_i
    while @i <= @total_users do
       @user = User.create(:name => "name_#{@i}", :email => "name_#{@i}@test.com")
       @event_count = rand(2 .. 10)
       @j = 1
       while @j <= @event_count do
         @name = "name_#{@i}_event_#{@j}"
         
         if @j == @event_count
           @name = "last_event"
         end

         if @j == 1
           @name = "first_event"
         end
         @event = @user.events.new( :name =>  @name,
            :description => "An event by name_#{@i}, event number is #{@j}",
            :location => (["Mercury", "Venus", "Saturn", "Jupyter", "Uranus", "Neptune"].sample(1)[0]),
            :start_time => "13-12-2019".to_date,
            :end_time => "14-12-2019".to_date,
            :user_id => @i
        )
        @event.save
        @j += 1
       end
       @total_events = @total_events + @event_count
       @i += 1

    end
    
    @i = 1
    while @i <= @total_users do
      @event_id = rand(1 .. @total_events)
      @invitation = Invitation.new(:user_id => @i, :event_id => @event_id)
      @invitation.save
      @i += 1
    end
    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user = User.find(params[:id]);
    rescue
      head 200
    end
    if( @user != nil)
      @user.destroy
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def destroyAll
    begin
      User.delete_all
      User.reset_pk_sequence
      Event.delete_all
      Event.reset_pk_sequence
      Invitation.delete_all
      Invitation.reset_pk_sequence
      Comment.delete_all
      Comment.reset_pk_sequence
    rescue
      head 200
    end
    
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        head 403
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
