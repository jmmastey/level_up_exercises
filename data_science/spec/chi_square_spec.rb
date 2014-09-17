require "spec_helper"
require "./chi_square"

def create_bernoulli(successes, failures)
  bernoulli = Bernoulli.new
  successes.times { bernoulli.update(true)  }
  failures.times { bernoulli.update(false) }
  bernoulli
end

describe ChiSquare do
  let (:chi_square) { ChiSquare.new }

  before(:each) do
    bernoulli = create_bernoulli(4, 4)
    chi_square.add(bernoulli)

    bernoulli = create_bernoulli(9, 7)
    chi_square.add(bernoulli)
  end

  it "should return correct chi-value" do
    expect(chi_square.value).to eq(0.0839160839160839)
    expect(chi_square).not_to have_rejected_null_hyp
  end
end
