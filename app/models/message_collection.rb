class MessageCollection
  include SqsUsable
 
  def initialize(type)
    super
  end
 
  def receive_message
    res = super
    res.data.messages
  end
 
  def batch_delete(messages)
    entries = []
    messages.each_with_index do |message, i|
      entries << { id: i.to_s, receipt_handle: message.receipt_handle }
    end
    super(entries)
  end
end