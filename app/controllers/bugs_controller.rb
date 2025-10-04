class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy assign resolve]
  #   load_resource

  # authorize_resource



  # GET /bugs or /bugs.json
  def index

    @pagy,@bugs = pagy( policy_scope(Bug),limit: 4)
      
    # @bugs = Bug.all
    #   if current_user.role == "QA"
      
    # elsif current_user.role =="developer"
    #   @bugs =Bug.joins(:project).where(projects:{developer_id: current_user.id})
    #   #  @bugs = Bug.joins(:project).where(projects: {developer_id: current_user.id })
    # else
    #   @bugs = current_user.bugs
    # end
   

    # logger.debug "Article should be valid: #{@bugs.name}"

    if params[:search].present?
      @bugs =  @bugs.where("bugs.name LIKE ? OR bugs.bug_status LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      # debugger
    end
    
    @bugs = @bugs.order(created_at: :desc)
    

   respond_to do |format|
      format.html
      
      format.turbo_stream
  end
end
def assign 
  authorize @bug, :assign?
  @bug.assign_id  = current_user.id
  if @bug.save 
        NotificationJob.perform_later("bug_assigned", @bug.id, current_user.id)
    redirect_to @bug,notice: "The bug   are assign to you : (<./>)"
    else
      redirect_to @bug,notice: "The bug are  nt assign to you "
  end
end
def resolve
  authorize @bug, :resolve?
  @bug.priority = "Completed"
  if @bug.save
    redirect_to @bug, notice: "Bug resolved!"
  else
    redirect_to @bug, alert: "Failed to resolve bug."
  end
end
  

  # GET /bugs/1 or /bugs/1.json
  def show
    authorize @bug
  end
 
  # GET /bugs/new
  def new
    @bug = Bug.new
    authorize @bug
  end

  # GET /bugs/1/edit
  def edit
    authorize @bug
  end

  # POST /bugs or /bugs.json
  def create
    @bug = current_user.bugs.build(bug_params)
        # @bug.user = current_user
        authorize @bug
        respond_to do |format|
          if @bug.save
            # debugger

              logger.debug "The article was saved and now the user is going to be redirected..."
        format.html { redirect_to @bug, notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    authorize @bug
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: "Bug was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    authorize @bug
    @bug.destroy!

    respond_to do |format|
      format.html { redirect_to bugs_path, notice: "Bug was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  

  private


  def assign_self 
    @bug = Bug.find(params[:id])
    authorize! :assign_self,@bug

    @bug.update(developer_id:current_user.id)
    redirect_to @bug,notice: "Bug assigned to you sucessfully "
  end
  # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:name, :description, :bug_status, :priority,:date, :project_id, :file)
    end

end

