class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update]

  # GET /comments
  # GET /comments.json
  def index
    #begin  
      @user_ids = []
      @event = Event.find(params[:event_id])
      @comments = @event.comments.all
      @comments = Comment.joins(:user).where(comments: {event_id: params[:event_id]})
      for @comment in @comments
        @user_ids << @comment.user_id
      end
      @users = User.find(@user_ids)
    #rescue
      #head 403
    #end  
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    begin
      @event = Event.find(params[:event_id])
    rescue
      head 403
    end
    @comment = @event.comments.new

  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    begin
      @event = Event.find(params[:event_id])
      @comment = @event.comments.new(comment_params)
    rescue
      head 403
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    begin
      @comment = Comment.find(params[:id]);
    rescue
      head 200
    end
    if( @comment != nil)
      @comment.destroy
    end
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      begin
        @comment = Comment.find(params[:id])
      rescue
        head 403
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :event_id, :body)
    end
end
