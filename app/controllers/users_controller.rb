class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:last_name, :first_name, :email).page params[:page]
    authorize @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    @campuses = Campus.all
  end

  # GET /users/1/edit
  def edit
    @campuses = Campus.all
    @roles = Role.grantable.order(:description)
    @password_updater = PasswordUpdater.new
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(create_user_params)
    if @user.save
      create_session( 
        email: @user.email,
        password: @user.password
      )
      redirect_to profile_path(@user), notice: 'Thank you for signing up!'
    else
      @campuses = Campus.all
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user
    
    # Non Grantable user roles will not be included in the user_params, we need
    # to merge them in or they will be wiped out on update.
    result = AssignUserRoles.call(user: @user, user_params: user_params)
    if @user.update( user_params.merge(role_ids: result.role_ids) )
        redirect_to edit_profile_path(@user), notice: 'User was successfully updated.'
    else
      @campuses = Campus.all
      @roles = Role.all
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Successfully removed user.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :campus_id, :department)
    end
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :campus_id, :department, role_ids: [])
    end
end
