class GradersController < ApplicationController
  before_action :set_grader, only: [:show, :edit, :update, :destroy]

  def index
    @graders = Grader.all
  end

  def show
  end

  def new
    @grader = Grader.new
  end

  def edit
  end

  def create
    @grader = Grader.new(grader_params)

    respond_to do |format|
      if @grader.save
        flash[:success] = 'Grader was successfully created.'
        format.html { redirect_to @grader }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @grader.update(grader_params)
        flash[:success] = 'Grader was successfully updated.'
        format.html { redirect_to @grader }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @grader.destroy
    respond_to do |format|
      flash[:success] = 'Grader was successfully destroyed.'
      format.html { redirect_to project_graders_url(@project) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grader
      @grader = Grader.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grader_params
      params.require(:grader).permit(:name, :email, :grader_type, :hack_name)
    end
end
