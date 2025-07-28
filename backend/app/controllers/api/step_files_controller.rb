module Api
  class StepFilesController < ApplicationController
    def create
      uploaded_file = params[:file]

      if uploaded_file.nil?
        render json: { error: 'No file uploaded' }, status: :bad_request
        return
      end

      temp_path = Rails.root.join('tmp', uploaded_file.original_filename)
      File.open(temp_path, 'wb') { |f| f.write(uploaded_file.read) }
      # stores files in backend/tmp

      render json: { message: 'File uploaded successfully', filename: uploaded_file.original_filename }, status: :ok
    end
  end
end
