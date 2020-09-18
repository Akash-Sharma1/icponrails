
# dummy job template 
class MailInqueueJobJob < ApplicationJob
  queue_as :default

  #task goes in default queue
  def perform(id, endTime)
    begin
      @interview = Interview.find(id)
      if @interview.endTime == endTime.to_datetime
        puts "destoyed"
        @interview.destroy
      end
    rescue
    end
  end

end
