require 'rubygems'
require 'open-uri'
require 'digest/md5'


  module Awslogic
    class Sqs

      def initialize() 
        @sqs_obj = AWS::SQS.new(
          :access_key_id => Settings.access_key,
          :secret_access_key => Settings.secret_key
        )
        @queue_url = Settings.queue_url
        Rails.logger.debug(Settings.access_key)
        Rails.logger.debug(Settings.secret_key)
        Rails.logger.debug(Settings.endpoint)
      end
      
      def send_message(message)
        @sqs_obj.queues[@queue_url].send_message(message)
      end
      
      def receive_message
        receive = @sqs_obj.queues[@queue_url].receive_message()
        if receive
          message = receive.body
          puts message
          Rails.logger.debug(message);
          receive.delete
          sleep 1
        else
          puts "empty sqs message";
        end
      end
      
      def self.poll_message
          sqs_obj = AWS::SQS.new(
            :access_key_id => Settings.access_key,
            :secret_access_key => Settings.secret_key
          )
          queue_url = Settings.queue_url
          sqs_obj.queues[queue_url].poll do |message|
            puts message.body
            sleep(1)
          end
      end
      
      def self.poll_message_by_prallel
        max_thread = 2 # 最大スレッド数
        ary_threads = []
        locker = Mutex::new
        max_thread.times do |i|
          ary_threads << Thread.start {
            self.poll_message
          }
        end
        ary_threads.each { |th| th.join }
      end
    end
  end