require 'aws-sdk'

module SqsUsable
  extend ActiveSupport::Concern
 
  def initialize(queue_name)
    @queue_name = queue_name
  end
 
  def sqs
    @sqs ||= Aws::SQS.new(region:Settings.region, endpoint:Settings.endpoint)
  end
 
  def receive_message(max_number = 10)
    sqs.receive_message(queue_url: queue_url, max_number_of_messages: max_number)
  end
 
  def batch_delete(entries)
    sqs.delete_message_batch(queue_url: queue_url, entries: entries)
  end
 
  def queue_url
    @queue_url ||= "#{Settings.queue_url}/#{@queue_name}"
  end
end