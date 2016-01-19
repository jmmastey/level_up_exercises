require_relative 'spec_helper'
require 'ostruct'

describe 'Overlord' do
	describe "GET '/'" do
	
		context 'no bomb, nothing set (first visit)' do
			it 'loads the homepage' do
				get '/'
				expect(last_response).to be_ok
			end

			it 'displays home page' do
				get '/'
				expect(last_response.body).to include("Mwahahaha!")
			end
		end

		context 'bomb is inactive' do
			let(:bomb){ OpenStruct.new(state: :inactive) }
			before do
				get '/', {}, {'rack.session' => { bomb: bomb } }
			end

			it 'displays inactive bomb page' do
				expect(last_response).to be_ok
			end

			it 'tells us the bomb is inactive' do
				note = "The bomb is initialized with activation and deactivation codes"
				expect(last_response.body).to include(note)
			end
		end

		context 'bomb is activated' do
			let(:bomb){ OpenStruct.new(state: :active) }
			before do
				get '/', {}, { 'rack.session' => { bomb: bomb } }
			end
				#		
				# double("bomb", state: :active)
				#
				# while initially trying to use a double in this test, Rack's underlying attempt to marshal this failed beneath the surface. Spent a few hours not getting it to work, and Richard helped me find:
				# 1. https://stackoverflow.com/questions/17399079/mocking-in-rspec2-causes-singleton-cant-be-dumped-in-sinatra-controller
				# 2. http://ruby-doc.org/core-2.2.2/Marshal.html#method-c-dump
				# As suggested by the StackOverflow answer, I used an OpenStruct (instead of using an instance of class Bomb)
			
			it 'displays active bomb page' do
				expect(last_response).to be_ok
			end

			it 'tells us the bomb is activated' do
				expect(last_response.body).to include("The bomb is active!")
			end

		end

		context 'bomb is exploded' do
			let(:bomb){ OpenStruct.new(state: :exploded) }

			before do
				get '/', {}, { 'rack.session' => { bomb: bomb } }
			end

			it 'displays exploded bomb page' do
				expect(last_response).to be_ok
			end

			it 'tells us the bomb exploded' do
				expect(last_response.body).to include("The bomb exploded")
			end
		end
	end

	describe "POST '/initialize'" do
		context 'bomb not initialized; no params passed' do
			let(:params){ { "actcode" => "", "deactcode" => "" } }
			before do
				post '/initialize', params
			end

			it 'initializes a bomb w/o params' do
				## adequate? Can't test last_response.body because we get a '302', for redirection.
				follow_redirect!
				expect(last_response).to be_ok
			end

			it 'redirects successfully' do
				expect(last_response.status).to eq(302)
			end

			it 'redirects to the inactive page' do
				expected = "The bomb is initialized with activation and deactivation"
				follow_redirect!
				expect(last_response.body).to include(expected)
			end
		end
	end

	describe "POST '/activate'" do
		context 'bomb activated with correct code' do
			let(:bomb){ OpenStruct.new(state: :inactive) }
			let(:params){ { "actcode" => "1234"} }

			before do
				allow(bomb).to receive(:enter_code).with("1234").and_return(true)
				allow(bomb).to receive(:state).and_return(:active)
			end

			def do_post
				post '/activate', params, { 'rack.session' => { bomb: bomb } }
			end

			it 'redirects successfully' do				do_post
				expect(last_response.status).to eq(302)
			end
		end
	end

	describe "POST '/deactivate'" do
		context 'correct code is entered' do
			let(:bomb){ Bomb.new }
			let(:params){ { "deactcode" => "0000"} }
			before do
				post '/deactivate', params, { 'rack.session' => { bomb: bomb } }
			end

			it 'should redirect when successful' do
				expect(last_response.status).to eq(302)
			end

			it 'should deactivate the bomb when correct code is entered' do
				expected = "The bomb is initialized with activation and deactivation codes"
				follow_redirect!
				expect(last_response.body).to include(expected)
			end
		end

	end
end