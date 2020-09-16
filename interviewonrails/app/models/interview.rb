class ModelValidator < ActiveModel::Validator
    def validate(record)
      return if record.participant1_id == nil || record.participant2_id == nil ||  
        record.startTime == nil || record.endTime == nil

      if record.participant1_id == record.participant2_id 
        record.errors[:base] << "Both participants should be different"
      end
      
      if record.startTime > record.endTime 
        record.errors[:base] << "Start Time can't be greater than endTime"
      end

      currentTime = Time.zone.now.to_datetime
      if record.startTime < currentTime 
        record.errors[:base] << "Interview can't be sheduled in the past"
      end

      overlaps = ValidateOverlappings(record, record.participant1_id)
      overlaps = ValidateOverlappings(record, record.participant2_id)
    end

    private
    def ValidateOverlappings(record, participant_id)
        overlaps = Interview.where(" (participant1_id = :id OR participant2_id = :id) AND ( 
            (startTime <= :l  AND endTime >= :r) 
            OR (startTime >= :l  AND startTime <= :r)
            OR (endTime >= :l  AND endTime <= :r) 
            OR (startTime >= :l  AND endTime <= :r))
            AND (id <> :recordid)",
            {l: record.startTime, r: record.endTime, id: participant_id, recordid: record.id})
        ShowError(participant_id, overlaps, record)
    end

    private
    def ShowError(participant_id, overlaps, record)
        return if overlaps == nil
        overlaps.each do |interview|
            record.errors.add(:participant_id, "Timing of user with id = #{participant_id}
                has overlapping intervals from  #{interview.startTime} to  #{interview.endTime} ")
        end
    end
end

class Interview < ApplicationRecord 
    has_many :users, as: :participant1 
    has_many :users, as: :participant2 
    validates :startTime, :endTime, :participant1_id, :participant2_id, presence: true 
    validates_with ModelValidator
end 
