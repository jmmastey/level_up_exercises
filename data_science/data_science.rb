require 'json'

json = JSON.parse(open('data.json').read).to_a

# 1. Total sample size and number of conversions for each cohort.
$n = json.count
puts "Sample size: #{$n}"
cohorts = json.partition{ |item|
	item['cohort'] == 'A'
}

def stats(cohort, name)
	count = cohort.inject(0){ |sum, data| sum += data['result']}
	puts "Cohort #{name}: #{count} / #{cohort.count}"
end

puts
stats(cohorts[0], 'A')
stats(cohorts[1], 'B')
puts

# 2. Conversion rate (including error bars) for each cohort with a 95% confidence.
# Square root of (p * (1-p) / n)

def confidence(cohort, name)
	count = cohort.inject(0){ |sum, data| sum += data['result']}

	p = (count.to_f / cohort.count.to_f).round(5)
	se = (2 * Math.sqrt(p * (1 - p) / $n.to_f)).round(5)
	puts "Conversion Rate = #{p}"
	puts "Standard Error = #{se}"

	low = (p - se).round(2)
	high = (p + se).round(2)
	puts "95% Confidence Interval for Cohort #{name}: "
	puts "|(#{low})--- (#{p}) ---(#{high})|"
end

confidence(cohorts[0], 'A')
puts
confidence(cohorts[1], 'B')
puts

# 3. Confidence level that the current leader is in fact better than random.
# (done in confidence)
