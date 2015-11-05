module DataScience
  class Cohort
    attr_reader :no, :yes

    def initialize(no, yes)
      @no = no
      @yes = yes
    end

    def size
      no + yes
    end

    def to_h
      { no: no, yes: yes }
    end
  end
end
