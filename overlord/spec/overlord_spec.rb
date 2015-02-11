require './spec/spec_helper.rb'

RSpec.describe Overlord do
  describe "#get '/'" do
    subject { get '/' }

    context "when (Bombs.count > 0) == false" do
      it "sets the session[:interface] == Interface.new" do
        subject
        expect(session[:interface]).to be_a(Interface)
      end
      it "renders the root.erb file" do
        expect(subject.body).to include(IO.binread('./views/root.erb'))
      end
    end
    context "when (Bombs.count > 0) == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "does not render root.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/root.erb"))
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
  end

  describe "#get '/boot_device'" do
    subject { get '/boot_device' }

    context "when the validate_event? == true" do
      it "renders the boot_device.erb template" do
        expect(subject.body).to include(IO.binread("./views/boot_device.erb"))
      end
      it "returns a status of 200" do
        expect(subject.status).to eq(200)
      end
    end
    context "when the validate_event? == false" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "redirects to /create_bomb" do
        expect(subject.location).to include("/create_bomb")
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
  end

  describe "#post '/boot_device'" do
    subject { post '/boot_device', params = { :boot_code => code } }

    context "when valid_boot_code? == true" do
      let(:code) { 6969 }

      it "executes to be_redirect" do
        expect(subject).to be_redirect
      end
      it "redirects to to '/create_bomb'" do
        expect(subject.location).to include("/create_bomb")
      end
    end
    context "when valid_boot_code? == false" do
      let(:code) { rand(1000..6000) }

      it "it does not redirect" do
        expect(subject).to_not be_redirect
      end
    end
    context "when boot_code == false/nil" do
      let(:code) { nil }

      it "it does not redirect" do
        expect(subject).to_not be_redirect
      end
    end
  end

  describe "#get '/create_bomb'" do
    subject { get '/create_bomb' }

    context "when the paylod.state != armed" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "redirects to /disarm_bomb" do
        expect(subject).to be_redirect
        expect(subject.location).to_not include("/create_bomb")
      end
      it "renders the create_bomb.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/create_bomb.erb"))
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
    context "when the payload.state != armed" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "renders the create_bomb.erb template" do
        expect(subject.body).to include(IO.binread("./views/create_bomb.erb"))
      end
      it "returns a status of 200" do
        expect(subject.status).to eq(200)
      end
    end
  end

  describe "#post '/create_bomb'" do
    subject { post '/create_bomb', params = { :timer => 30, :disarming_code => 6969, :max_attempts => 3 } }

    context "when configure_settings && deploy  == true"  do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "redirects to /disarm_bomb" do
        expect(subject).to be_redirect
        expect(subject.location).to include("/disarm_bomb")
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
    context "when configure_settings && deploy == false" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "does not render create_bomb.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/create_bomb.erb"))
      end
      it "returns a status of 404" do
        expect(subject.status).to eq(404)
      end
    end
  end

  describe "#get '/disarm_bomb'" do
    subject { get '/disarm_bomb' }

    context "when the validate_event? == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "renders the disarm_bomb.erb template" do
        expect(subject.body).to include(IO.binread("./views/disarm_bomb.erb"))
      end
    end
    context "when the validate_event? == false" do
      before :each do
        b = Bombs.new
        b.activate # I am using just one here instead of others
      end
      it "does not render disarm_bomb.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/disarm_bomb.erb"))
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
  end

  describe "#post '/disarm_bomb'" do
    let(:disarming_code) { rand(1000..9999) }
    subject { post '/disarm_bomb', params = { :disarming_code => disarming_code } }

    context "when disable == true" do
      before :each do
        b = Bombs.new(:disarming_code => disarming_code)
        b.activate
        b.arm
      end
      it "redirects to /disarmed_bomb" do
        expect(subject).to be_redirect
        expect(subject.location).to include("/disarmed_bomb")
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
    context "when disable == false" do
    end
  end

  describe "#get '/disarmed_bomb'" do
    subject { get '/disarmed_bomb' }

    context "when the validate_event? == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
        b.disarm
      end
      it "renders the disarm_bomb.erb template" do
        expect(subject.body).to include(IO.binread("./views/disarmed_bomb.erb"))
      end
    end
    context "when the validate_event? == false" do
      before :each do
        b = Bombs.new
        b.activate # I am using just one here instead of others
      end
      it "does not render disarm_bomb.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/disarmed_bomb.erb"))
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
  end

  describe "#post '/detonate_bomb'" do
    subject { post '/detonate_bomb' }

    context "when detonate == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "detonates the session_interface.payload" do
        subject
        expect(session[:interface].payload.state).to eq("detonated")
      end
      it "returns a status of 200" do
        expect(subject.status).to eq(200)
      end
    end
    context "when detonate == false" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "returns a status of 500" do
        expect(subject.status).to eq(500)
      end
    end
  end

  describe "#get '/detonated_bomb'" do
    subject { get '/detonated_bomb' }

    context "when the validate_event? == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
        b.detonate
      end
      it "renders the detonated_bomb.erb template" do
        expect(subject.body).to include(IO.binread("./views/detonated_bomb.erb"))
      end
    end
    context "when the validate_event? == false" do
      before :each do
        b = Bombs.new
        b.activate # I am using just one here instead of others
      end
      it "does not render detonated_bomb.erb template" do
        expect(subject.body).to_not include(IO.binread("./views/detonated_bomb.erb"))
      end
      it "returns a status of 302" do
        expect(subject.status).to eq(302)
      end
    end
  end

  describe "#post '/destroy_bomb'" do
    subject { post '/destroy_bomb' }

    context "when valid_event? == true" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
        b.disarm
      end
      it "returns a status of 200" do
        expect(subject.status).to eq(200)
      end
    end
    context "when valid_event? == false" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "returns a status of 500" do
        expect(subject.status).to eq(500)
      end
    end
  end
end
