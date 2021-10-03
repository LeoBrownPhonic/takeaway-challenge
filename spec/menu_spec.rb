require "menu"

describe Menu do
  describe "#see_list" do
    it "returns a list of dishes" do
      expect(subject.see_list()).to eq subject.list
    end
  end

  describe "#place_order" do
    
    it "creates a list of selected dishes" do
      subject.place_order(1, 2)
      expect(subject.order).to eq subject.list.slice(1, 2)
    end

    it "returns a total cost for the meal" do
      expect(subject.place_order(1, 2)).to eq 9
    end
  end

  describe "#verify_order" do
    it "shows the total alongside the dishes ordered" do
      subject.place_order(1, 2)
      expect(subject.verify_order).to eq "Your total is £#{subject.total} for the following #{subject.order}"
    end
  end

  describe "#confirm_order" do
    let(:sms_sender) { double SmsSender, :new => true, :send_text => true }
    # it "creates a message confirming delivery before 1 hours time" do
    #   subject.place_order(1, 2)
    #   t = Time.new
    #   hour_plus1 = ((t.strftime("%H").to_i) + 1)
    #   subject.confirm_order
    #   expect(subject.delivery_message).to eq "Thank you! Your order was placed and will be delivered before #{t.strftime("at #{hour_plus1}:%M%p")}"
    # end

    it "uses the send_text method to send delivery_message" do
      menu = Menu.new(sms_sender)
      expect(menu.confirm_order).to be_truthy
    end
  end

  describe "#sms_delivery_message" do
    let(:fake_sms_sender) { double 'sms_sender', :send_text => true }
    it "creates an instance of the SmsSender class with the argument 'delivery_message'" do
      expect(subject.sms_delivery_message(fake_sms_sender)).to be_truthy
      
    end
  end

end
