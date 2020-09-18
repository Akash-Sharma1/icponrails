class ModelValidator < ActiveModel::Validator
  
  def validate(record)
    return if record.startTime == nil || record.endTime == nil
    if record.users.length() < 2
      record.errors[:base] << "At least two users are necessary for the interview to be scheduled"
    end
    
    ValidateTimings(record)
    ValidateOverlappingsForAllUsers(record)
  end

  private
  def ValidateTimings(record)
    if record.startTime > record.endTime 
      record.errors[:base] << "Start Time can't be greater than endTime"
    end

    if record.startTime < Time.zone.now.to_datetime 
      record.errors[:base] << "Interview can't be sheduled in the past"
    end
  end

  private
  def ValidateOverlappingsForAllUsers(record)
    users = record.users
    
    users.each do |user|
      interviews = user.interviews
      CheckOverlapsInInterviews(interviews, record, user.id)
    end

  end

  private
  def CheckOverlapsInInterviews(interviews, record, user_id)
      interviews.each do |interview|
          if record.id != interview.id
            CheckOverlapsInSlot(interview, record, user_id)
          end
      end
  end

  private
  def CheckOverlapsInSlot(interview, record, user_id)
    puts interview.endTime.to_s+" "+record.startTime.to_s+" "+interview.startTime.to_s+" "+record.endTime.to_s
    if interview.endTime < record.startTime || interview.startTime > record.endTime
      return
    else
      record.errors.add(:users, "Timing of user with id = #{user_id}
        has overlapping intervals from  #{interview.startTime} to  #{interview.endTime} ")
    end
  end
end

class Interview < ApplicationRecord
  has_many :schedules, dependent: :delete_all
  has_many :users, through: :schedules
  
  validates :startTime, :endTime, presence: true
  validates_with ModelValidator
end
