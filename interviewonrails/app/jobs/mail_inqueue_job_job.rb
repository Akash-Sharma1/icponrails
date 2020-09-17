
# dummy job template 
class MailInqueueJobJob < ApplicationJob
  queue_as :default

  #task goes in default queue
  def perform(*args)
    #heavy task
  end

end
