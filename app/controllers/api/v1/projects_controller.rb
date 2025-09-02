class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
    skip_before_action :verify_authenticity_token  

      #  load_resource
  # authorize_resource
  # GET /projects or /projects.json
  def index
      
    #   if current_user.role == "QA"
    #     @projects = Project.all
    #   elsif current_user.role == "developer"
    #     @projects = Project.where(developer_id: current_user.id)
    # else
    #   @projects = current_user.projects
    # end
    
    # @projects = policy_scope(Project)
    @projects = Project.all
    # render json: Project.all
    render json: @projects
 
    
    
  end

  # GET /projects/1 or /projects/1.json
  def show
    # authorize @project
    render json: @project
  end

  # GET /projects/new
  def new
    @project = Project.new
    render json: @project
    # authorize @project
  end

  # GET /projects/1/edit
  def edit
render json: @project
    # authorize @project
  end

  # POST /projects or /projects.json
  def create
    #   @project = current_user.projects.build(project_params)
    @project = Project.new(project_params)
    debugger
    # authorize  @project
    respond_to do |format|
      if @project.save
        # render json: @project
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.jsonNotificationMailer.project_updated(@project, @user).deliver_later
 
  def update
    respond_to do |format|
    #   authorize @project
      if @project.update(project_params)

    #        User.where(role: "Manger").find_each do |man|
    #     NotificationJob.perform_later("project_updated", @project.id, man.id)
        
    #   end
      # NotificationMailer.project_updated(@project, @user).deliver_later
        format.html { redirect_to @project, notice: "Project was successfully updated.", status: :see_other }
        format.json { render json: @project, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    # authorize @project
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Project was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:projects).permit( :name, :description,:developer_id, :user_id)
    end
end
