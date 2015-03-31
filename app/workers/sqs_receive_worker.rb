class SqsReceiveWorker
  include Sidekiq::Worker
 
  def perform(queue_name)
    collection = MessageCollection.new(queue_name)
 
    if messages = collection.receive_message then
      messages.each do |message|
        # TODO: 何かしらの処理…
        puts message
      end
      collection.batch_delete(messages)
    else
      puts "queue is empty"
    end
    SqsReceiveWorker.perform_in(1.second, queue_name)
  end
end