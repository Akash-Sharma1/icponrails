# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

# # to be appraised of mailing errors
# config.action_mailer.raise_delivery_errors = true

# # to deliver to the browser instead of email
# config.action_mailer.delivery_method = :letter_opener
