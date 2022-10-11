require "xmlrpc/client"
class SMSMovistarApi
  attr_accessor :client

  def initialize
    @client = XMLRPC::Client.new2(url)
    @client.instance_variable_get("@http").verify_mode=OpenSSL::SSL::VERIFY_NONE
  end

  def url
    return "" unless end_point_available?
    Rails.application.secrets.sms_end_point
  end

  def sms_deliver(phone, code)
    return stubbed_response unless end_point_available?

    response = client.call('MensajeriaNegocios.enviarSMS', Rails.application.secrets.sms_username, Rails.application.secrets.sms_password, request(phone, code))
    success?(response)
  end

  def send_sms(phone, message)
    response = client.call('MensajeriaNegocios.enviarSMS', Rails.application.secrets.sms_username, Rails.application.secrets.sms_password, [[phone, message, '217812']])
  end

  def request(phone, code)
    [[
      phone,
      I18n.t("verification.sms.message", code: code),
      '217812'
    ]]
  end

  def success?(response)
    response == [0]
  end

  def end_point_available?
    Rails.env.development? || Rails.env.staging? || Rails.env.preproduction? || Rails.env.production?
  end

  def stubbed_response
    [0]
  end

end
