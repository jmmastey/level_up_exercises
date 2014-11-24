require 'rails_helper'
require 'rspec/collection_matchers'

describe Feedback do
  let(:feedback_no_subject) do
    described_class.new(message: 'hello')
  end

  let(:feedback_no_message) do
    described_class.new(subject: 'hello')
  end

  let(:feedback_blank_fields) do
    described_class.new(message: '', subject: '')
  end

  describe 'valid?' do
    it 'require both subject and message' do
      expect(feedback_no_subject).not_to be_valid
      expect(feedback_no_message).not_to be_valid
    end

    it 'message and subject cannot be empty' do
      expect(feedback_blank_fields).not_to be_valid
    end
  end
end
