module StocksHelper
  def calculate_rating_helper
    pe_score = calculate_pe_score
    peg_score = calculate_peg_score
    ticker_score = calculate_ticker_score
    average_200_day_score = calculate_200_day_average_score

    pe_score + peg_score + ticker_score + average_200_day_score
  end

  private

  def calculate_pe_score
    case pe_ratio
      when 0, 25..Float::INFINITY
        0
      when 20..25
        1
      when 17..20
        2
      when 15..17
        2.5
      when 0..15
        3
      else
        0
    end
  end

  def calculate_peg_score
    case peg_ratio
      when (0..0.9)
        3
      when (0.9..1.1)
        2.5
      when (1.1..1.75)
        2
      when (1.75..2.25)
        1.5
      when (3..3.5)
        1
      when (3.5..Float::INFINITY)
        0.5
      else
        0
    end
  end

  def calculate_ticker_score
    case converted_ticker.to_i
      when 3..Float::INFINITY
        1
      when 1..2
        0.5
      else
        0
    end
  end

  def calculate_200_day_average_score
    case calculate_delta(moving_average_200_day, asking_price)
      when 15..Float::INFINITY
        3
      when 12..15
        2.5
      when 9..12
        2
      when 6..9
        1.5
      when 3..6
        1
      when 0..3
        0.5
      else
        0
    end
  end

  def calculate_delta(average, current)
    (current - average) / average * 100
  end
end
