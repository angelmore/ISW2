class MonthYear
  def initialize(month, year)
    raise Exception, 'Invalid month' unless (1..12) === month
    raise Exception, 'Invalid year' if year <= 0
    @month = month
    @year = year
  end

  def month
    @month
  end

  def year
    @year
  end
end