require 'twilio-ruby'

class Menu
  attr_reader :list, :order, :total, :delivery_message

  def initialize(sms_sender = SmsSender)
    @list = {
      1 => "cod £5",
      2 => "fishcake £4",
      3 => "chips £3"
    }
    @order = []
    @sms_sender = sms_sender
  end

  def see_list
    @list
  end

  def place_order(*item)
    @order = @list.slice(*item)
    @total = @order.values.map { |v| v.match(/\d/)[0].to_i }.sum
  end

  def verify_order
    p "Your total is £#{@total} for the following #{@order}"
  end

  def confirm_order
    @delivery_message = "Thank you! Your order was placed
    and will be delivered before #{time_plus_1hour}"
    sms_delivery_message(sms_sender = @sms_sender.new(@delivery_message))
  end

  def sms_delivery_message(sms_sender)
    sms_sender.send_text
  end

  private

  def time_plus_1hour
    t = Time.new
    hour_plus1 = ((t.strftime("%H").to_i) + 1)
    t.strftime("at #{hour_plus1}:%M%p")
  end

end
