require "httplog"

HttpLog.options[:logger] = Rails.logger
HttpLog.options[:log_headers] = true
