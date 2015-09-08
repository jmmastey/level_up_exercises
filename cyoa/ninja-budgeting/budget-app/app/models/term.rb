class Term < ActiveRecord::Base
  has_many :transactions
  belongs_to :user
  validates_presence_of :month, :year, :user_id
  validates_uniqueness_of :month, scope: [:month, :year, :user_id]
  serialize :options, Hash

  def date
    "#{Date::MONTHNAMES[month]} #{year}"
  end

  def budgeted_amount_for_category(category)
    return 0 if options[category][:budgeted_amount].empty?
    amount = 0.0
    options[category][:budgeted_amount].each do |_, value|
      amount += value
    end
    amount
  end

  def total_budgeted_amount
    total = 0.0
    options.each do |name, values|
      unless values[:budgeted_amount].empty?
        total += (budgeted_amount_for_category(name) - values[:amount_spent])
      end
    end

    total
  end

  def remaining_money(category)
    amount = budgeted_amount_for_category(category)
    amount -= options[category][:amount_spent]
    amount
  end
end
