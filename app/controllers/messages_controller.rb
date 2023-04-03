class MessagesController < ApplicationController
  def index
    response = { "messages" => {} }
    if params["slack_file"]
      max_size = 1024 ** 2
      Zip::File.open(params["slack_file"].tempfile) do |zip_file|
        # Handle entries one by one
        directory = ""
        messages = []
        first = true
        zip_file.each do |entry|
          # puts "Extracting #{entry.name}"
          raise "File too large when extracted" if entry.size > max_size
          if entry.ftype == :directory #entry is directory
            if directory != ""
              response["messages"][directory] = messages.sort_by { |m| m["ts"] }
              messages = []
            end
            directory = entry.name[0..-2] #remove slash
          elsif entry.ftype == :file && entry.name.match(/(?<![0-9])[a-z]*.json/) #need to match
            name = entry.name[0..-6] #remove .json
            response[name] = JSON.parse(entry.get_input_stream.read)
            if directory != ""
              response["messages"][directory] = messages.sort_by { |m| m["ts"] }
              messages = []
            end
            messages = []
            directory = ""
          elsif entry.ftype == :file #entry is a subfolder file
            content = JSON.parse(entry.get_input_stream.read)
            content = content.map do |m|
              start = directory.length + 1
              m["date"] = entry.name[start..-6]
              m
            end
            messages = [*messages, *content]
          end
        end
        puts "Adding #{directory}"
        response["messages"][directory] = messages.sort_by { |m| m["ts"] }
      end
      render json: response
    else
      render json: { errors: ["Unable to parse file"] }, status: :unprocessable_entity
    end
  end
end
