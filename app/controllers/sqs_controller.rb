class SqsController < ApplicationController
  def add
    #sqs = Logic::Aws::Sqs.new()
    sqs = Awslogic::Sqs.new()
    sqs.send_message('Hello Ruby Sqs!!')
    @message = 'sqsにメッセージを登録しました。';
  end
end
