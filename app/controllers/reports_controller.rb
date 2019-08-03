class ReportsController < ApplicationController
  before_action :set_report, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show] #only: [:new, :edit, :update, :create, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @reports = Report.paginate(page: params[:page], per_page: 2)
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def update
    if @report.update(report_params)
      flash[:success] = "Report updated"
      redirect_to report_path(@report)
    else
      render :edit
    end
  end

  def create
    @report = Report.new(report_params)

    @report.user = current_user

    if @report.save
      flash[:success] = "Report created"
      redirect_to report_path(@report)
    else
      render :new
    end
  end

  def destroy
    @report.destroy

    flash[:success] = "Report deleted"
    redirect_to reports_path
  end

  def show
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if (!logged_in? || current_user != @report.user) && (!current_user.admin?)
      flash[:danger] = "You are not authorized"
      redirect_to reports_path
    end
  end
end
