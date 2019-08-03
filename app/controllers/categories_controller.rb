class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 2)
  end

  def show
    @category_reports = @category.reports.paginate(page: params[:page], per_page: 2)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:danger] = "You are not authorized"
      redirect_to categories_path
    end
  end
end
