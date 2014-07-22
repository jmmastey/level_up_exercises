require 'json'
require 'date'

class SplitalizeDataLoader
	def self.parse(source_filename)

		start_date = nil
		end_date = nil
		a_total = 0
		b_total = 0
		a_conv = 0
		b_conv = 0

		File.open(source_filename, "r") do |source_file|

			parsed_data = JSON.parse(source_file.read)

			start_date = Date.parse(parsed_data[0]['date'])
			end_date = Date.parse(parsed_data[0]['date'])

			parsed_data.each do |event|

				event_date = Date.parse(event['date'])

				start_date = event_date if event_date < start_date
				end_date = event_date if event_date > end_date

				if event['cohort'] == 'A'
					a_total += 1
					a_conv += 1 if event['result'] == 1
				else
					b_total += 1
					b_conv += 1 if event['result'] == 1
				end

			end

		end

		data = Hash.new()

		data[:start_date] = start_date
		data[:end_date] = end_date
		data[:a_total] = a_total
		data[:b_total] = b_total
		data[:a_conv] = a_conv
		data[:b_conv] = b_conv

		data

	end
end
