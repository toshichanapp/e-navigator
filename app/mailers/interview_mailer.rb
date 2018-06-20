class InterviewMailer < ApplicationMailer

  def require_decide_date(interview_params, current_user)
    @interviewer = User.find(interview_params[:interviewer_id])
    @user = current_user
    mail(to: @interviewer.email, cc: current_user.email, subject: '面談の日程の')
  end

  def approval_date(interview)
    @interview = interview
    @user = @interview.user
    mail(to: @user.email, subject: '面談日程が決定しました')
  end

  def dissmiss_date(user)
  
  end
end
