class InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    if params[:back]
      render :action => 'new'
    else
      InquiryMailer.received_email(@inquiry).deliver_now
      InquiryMailer.send_message_to_user(@inquiry).deliver_now
      render :action => 'thanks'
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end

end
