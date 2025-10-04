class ReportsController < ApplicationController
  before_action :set_report , only: %i[show]

#  load_resource
#   authorize_resource
  def index
    @reports = policy_scope(Report)
    # authorize @reports
    if params[:find].present?
      @reports = @reports.where("report_name LIKE ? OR report_description LIKE ?","%#{params[:find]}%","%#{params[:find]}%")

    end

    respond_to  do |format|
      format.html
      format.turbo_stream

    end
    
    # @reports = Report.all

  end

  def create

    @report = Report.build(report_pramas)
    authorize @report
    if @report.save
      redirect_to @report ,notice: "The report are suceesfully addd"
    else
      render :new ,status: :unprocessable_entity
    end
    
  end
  
  def new
      @bug = Bug.find(params[:bug_id]) if params[:bug_id]
    @report = Report.new(bug: @bug)
    authorize @report
  end
  
  def show
    authorize @report
    # @report = Report.find(params.expect(:id))
  end

  private
  def set_report

    @report = Report.find(params.expect(:id))
  end
  def report_pramas
    params.require(:report).permit(:report_name,:report_description,:bug_id)
  end


end
