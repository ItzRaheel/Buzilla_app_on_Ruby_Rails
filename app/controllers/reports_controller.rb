class ReportsController < ApplicationController
  before_action :set_report , only: %i[show]

#  load_resource
#   authorize_resource
  def index
    @reports = policy_scope(Report)
    authorize @reports
    @reports = Report.all
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
    @report = Report.new
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
    params.require(:report).permit(:report_name,:report_description)
  end


end
