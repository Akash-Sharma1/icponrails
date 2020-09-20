class InterviewSerializer < ActiveModel::Serializer
  attributes :id, :startTime, :endTime
  has_many :users
end
