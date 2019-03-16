class InquiryMailer < ApplicationMailer
  # 管理者への送信メール
  default from: 'noreply@gmail.com'
  def received_email(inquiry)
    @inquiry = inquiry
    mail to: "nozomimatusmoto1105@gmail.com",
          subject: "お問い合わせメールが届きました"
  end

  # ユーザーへの自動返信メール
  def send_message_to_user(inquiry)
    @inquiry = inquiry
    mail to: @inquiry.email,
         subject: "お問い合わせありがとうございます"
  end
end
