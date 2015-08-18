require_relative "spec_helper"
require_relative "overlord_helper"

describe Overlord do
  let(:valid_code) { "1234" }
  let(:invalid_code) { "Get outta here" }
  let(:disarm_code) { "0000" }
  let(:ghost_wire) { 999 }
  let(:wire_index) { 1 }
  let(:short_time) { 1 }
  let(:status) do
    get '/BOMB/v1/'
    parse_response(last_response.body)
  end
  let(:armed_bomb) do
    post '/BOMB/v1/', code: valid_code
    parse_response(last_response.body)
  end
  let(:error_bomb) do
    post '/BOMB/v1/', code: invalid_code
    parse_response(last_response.body)
  end
  let(:wires) do
    get '/BOMB/v1/wires'
    parse_response(last_response.body)
  end

  it "allows accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end

  describe "/BOMB/v1/" do
    it "provides the status as valid json" do
      expect(status).not_to eq(false)
    end

    it "provides a state value" do
      expect(status).to have_key(:state)
    end

    it "provides a clock value" do
      expect(status).to have_key(:clock)
    end

    it "provides an error value" do
      expect(status).to have_key(:error)
    end

    it "can be posted to" do
      post '/BOMB/v1/'
      expect(last_response).to be_ok
    end

    it "provides status on post" do
      expect(armed_bomb).not_to eq(false)
    end

    it "returns the current status on post" do
      expect(armed_bomb[:state]).to eq(status[:state])
    end

    it "makes state active when a valid code is posted" do
      expect(status[:state]).to eq('inactive')
      expect(armed_bomb[:state]).to eq('active')
    end

    it "provides an error code when an invalid code is posted" do
      expect(error_bomb[:error]).not_to be_empty
    end
  end

  describe "/BOMB/v1/trigger" do
    let(:triggered_bomb) do
      post '/BOMB/v1/trigger'
      parse_response(last_response.body)
    end

    it "does nothing with an inactive bomb" do
      expect(triggered_bomb[:clock].to_s).to be_empty
    end

    it "starts the clock on an active bomb" do
      expect(armed_bomb[:clock].to_s).to be_empty
      expect(triggered_bomb[:clock].to_s).not_to be_empty
      expect(status[:clock]).to be < triggered_bomb[:clock]
    end
  end

  describe "/BOMB/v1/wires" do
    it "provides an JSON response" do
      expect(wires).not_to eq(false)
    end

    it "provides an array of wires" do
      expect(wires.size).to be > 0
    end

    describe "each wire" do
      let(:wire) { wires.last }

      it "has a type" do
        expect(wire).to have_key(:type)
      end

      it "has an intact state" do
        expect(wire).to have_key(:intact)
      end

      it "has an index" do
        expect(wire).to have_key(:index)
      end
    end
  end

  describe "/BOMB/v1/wire/cut" do
    let(:cut_invalid_wire) do
      post '/BOMB/v1/wire/cut'
      parse_response(last_response.body)
    end
    let(:cut_ghost_wire) do
      post '/BOMB/v1/wire/cut', index: ghost_wire
      parse_response(last_response.body)
    end
    let(:cut_disarming_wire) do
      post '/BOMB/v1/wire/cut', index: wire_index
      wires[wire_index]
    end

    it "provides an error if no index is given" do
      expect(cut_invalid_wire[:error]).not_to be_empty
    end

    it "provides an error of the wire doesn't exist" do
      expect(cut_ghost_wire[:error]).not_to be_empty
    end

    it "cuts a valid wire" do
      expect(cut_disarming_wire[:intact]).to be_falsey
    end
  end

  describe "/BOMB/v1/short" do
    let(:short_circuit) do
      post '/BOMB/v1/short'
      parse_response(last_response.body)
    end

    it "triggers a shortened timer" do
      expect(short_circuit[:clock]).to be_within(0.2).of(short_time)
    end
  end
end
