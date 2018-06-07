class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[show edit update destroy]

  def index
    @interviews = current_user.interviews
  end

  def show; end

  def new
    @interview = Interview.new
  end

  def create
    @interview = Interview.new(interview_params)
    @interview.user_id = current_user.id
    @interview.status = 2
    if @interview.save
      redirect_to user_interview_url(current_user, @interview), success: ['created!']
    else
      render :new
    end
  end

  def edit; end

  def update
    @interview.attributes = interview_params
    if @interview.save
      redirect_to user_interviews_url(current_user), success: ['updated!']
    else
      render :edit
    end
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_url(current_user), success: ['deleted']
  end

  private

  def interview_params
    params.require(:interview).permit(:date)
  end

  def set_interview
    @interview = current_user.interviews.find(params[:id])
  end
end
