require 'mini_magick'
require 'aws-sdk-sqs'


task :photos => :environment do

    sqs_url = 'https://sqs.us-east-1.amazonaws.com/050073096789/design_match_queue'
    sqs = Aws::SQS::Client.new(region: 'us-east-1',
                               access_key_id: ENV['KEY_OSCAR'],
                               secret_access_key: ENV['SECRET_OSCAR'])

    resp = sqs.receive_message(queue_url: sqs_url, max_number_of_messages: 1)
    resp.messages.each do |m|
        @design = Design.find_by_id(m.body)

        if @design.is_available
          # Deletes a message from the queue if the design is already processed
          sqs.delete_message({queue_url: sqs_url, receipt_handle: m.receipt_handle})
        end

        unless @design.is_available
            uri = URI("http:"+@design.original_design.url)
            image = MiniMagick::Image.open(uri)
            image.resize "800x600"
            image.format "png"
    
            fullname = @design.designer_name + ' ' + @design.designer_last_name
    
            image.combine_options do |c|
                c.gravity 'Southwest'
                c.draw 'text 10,34 "'+fullname+'"'
                c.draw 'text 10,0 "'+@design.created_at.to_s+'"'
                c.pointsize '34'
                c.fill("#FFFFFF")
            end
    
            #image.write("./storage/sample.png")
            #file = File.open("./storage/sample.png")

	    image.write("/home/ubuntu/shared_client/sample.png")
            file = File.open("/home/ubuntu/shared_client/sample.png")


            @design.processed_design = file
            file.close
            @design.is_available = true
            @design.save
    
            # An email is sent to notify the designer that his design is ready
            UserMailer.notification_design(@design.designer_email, @design.designer_name).deliver_now

            sqs.delete_message({queue_url: sqs_url, receipt_handle: m.receipt_handle})
        end

    end
end
