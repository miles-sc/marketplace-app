module Api
  class StepJobsController < ApplicationController


    def create
      result = StepJob.process_upload(params[:file])

      if result[:success]
        render json: result[:data], status: :ok
      else
        render json: { error: result[:error] }, status: result[:status]
      end
    end


    def show
      job = StepJob.find_by(job_id: params[:id])
      return render json: { error: "Job not found" }, status: :not_found unless job

      render json: {
        job_id: job.job_id,
        filename: job.filename,
        metrics: job.metrics
      }, status: :ok
    end


    def file
      job = StepJob.find_by(job_id: params[:id])
      return render json: { error: "Job not found" }, status: :not_found unless job

      requested_filename = [params[:filename], params[:format]].compact.join(".")
      file_path = job.file_path(requested_filename)
      return render json: { error: "File not found" }, status: :not_found unless File.exist?(file_path)

      mime_type = StepJob.mime_type_for(requested_filename)
      send_file file_path, disposition: "inline", type: mime_type
    end

  end
end
