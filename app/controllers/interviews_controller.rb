class InterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_interview, only: %i[show edit update destroy]

  def index
    # status: {dissmissed: 0, approval: 1, pending: 2}
    @interviews = @user.interviews
  end

  def show; end

  def new
    @interview = Interview.new
  end

  def create
    @interview = Interview.new(interview_params)
    @interview.user_id = current_user.id
    @interview.status = :pending
    if @interview.save
      redirect_to user_interview_url(current_user, @interview), success: 'created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    @interview.attributes = interview_params
    if @user == current_user
      if @interview.status == 'approval'
        redirect_to user_interviews_url(current_user), danger: '承認された日程を変更することはできません'
      else
        @interview.save
        render :edit, success: 'updated'
      end
    else
      case interview_params[:status]
      when 'approval'
        interviews = Interview.where(user_id: @user.id).where.not(id: @interview.id)
        interviews.update_all(status: 'dissmissed')
      when 'dissmissed'
      end
      if @interview.save
        redirect_to user_interviews_url(@user), success: 'updated!'
      else
        flash.now[:danger] = @interview.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_url(current_user), success: 'deleted'
  end

  private

  def interview_params
    params.require(:interview).permit(:date, :status)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_interview
    @interview = @user.interviews.find(params[:id])
  end
end
