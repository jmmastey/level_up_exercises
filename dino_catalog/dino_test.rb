require 'minitest/autorun'
begin
  require_relative 'dinoclass.rb'
rescue LoadError => e
  puts "\n\n#{e.backtrace.first} #{e.message}"
  puts DATA.read
  exit 1
end

class DinoDexTest < MiniTest::Unit::TestCase
  def test_class
    #skip
    assert_equal 'Diplocaulus', DinoDex.new.find('Late Permian')
  end

  def test_filter_bipeds
    #skip
    assert_equal 'Albertosaurus', DinoDex.new.find('Biped')
  end

  def test_add_two_users_with_initial_limit
    skip
    assert_equal 'Lisa: $0 Tom: $0 ', AccountManager.new.process_transactions('Add Tom 4111111111111111 $1000 Add Lisa 5454545454545454 $1000')
  end

  def test_charge_existing_user_account
    skip
    assert_equal 'Tom: $100 ', AccountManager.new.process_transactions('Add Tom 4111111111111111 $1000 Charge Tom $100')
  end

  def test_charge_over_user_limit
    skip
    assert_equal 'Tom: $0 ', AccountManager.new.process_transactions('Add Tom 4111111111111111 $1000 Charge Tom $1100')
  end

  def test_charge_over_user_limit_when_user_has_balance
    skip
    assert_equal 'Tom: $200 ', AccountManager.new.process_transactions('Add Tom 4111111111111111 $1000 Charge Tom $200 Charge Tom $1000')
  end

  def test_credit_existing_user_account
    skip
    assert_equal 'Quincy: $-1000 ', AccountManager.new.process_transactions('Add Quincy 4111111111111111 $1000 Credit Quincy $1000')
  end

  def test_sample_input_from_instructions
    skip
    assert_equal 'Lisa: $-93 Quincy: error Tom: $500 ', AccountManager.new.process_transactions('Add Tom 4111111111111111 $1000 Add Lisa 5454545454545454 $3000 Add Quincy 1234567890123456 $2000 Charge Tom $500 Charge Tom $800 Charge Lisa $7 Credit Lisa $100 Credit Quincy $200 ')
  end


end

__END__
