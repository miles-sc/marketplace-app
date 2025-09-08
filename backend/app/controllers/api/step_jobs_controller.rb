require "securerandom"
require "fileutils"

module Api
  class StepJobsController < ApplicationController
    BINARY_SCRIPT_DIR= Rails.root.parent.join("step_processing","build")
    RENDER_SCRIPT_DIR= Rails.root.parent.join("step_processing","step_render_views.py")
    CONDA_ENV="cq"

    def create
      uploaded_file = params[:file]

      if uploaded_file.nil?
        render json: { error: 'No file uploaded' }, status: :bad_request
        return
      end

      unless uploaded_file.original_filename.downcase.end_with?(".step", ".stp")
        render json: { error: "Unsupported file type" }, status: :unprocessable_entity
        return
      end

      job_id= SecureRandom.uuid
      job_directory= Rails.root.join("storage","step_jobs",job_id)
      FileUtils.mkdir_p(job_directory)

      step_dir= job_directory.join(uploaded_file.original_filename.downcase)
      File.open(step_dir, "wb") { |f| f.write(uploaded_file.read) }

      volume = (`#{BINARY_SCRIPT_DIR.join("step_volume")} #{step_dir}`.to_f/(25.4**3)).round(1)
      area   = (`#{BINARY_SCRIPT_DIR.join("step_surface_area")} #{step_dir}`.to_f/(25.4**2)).round(1)

      `conda run -n #{CONDA_ENV} python #{RENDER_SCRIPT_DIR} #{step_dir} #{job_directory}`

      StepJob.create!(
        job_id: job_id,
        filename: uploaded_file.original_filename.downcase,
        metrics: { volume: volume, surface_area: area }
      )

      render json: {
        job_id: job_id,
        filename: uploaded_file.original_filename.downcase,
        metrics: { volume: volume, surface_area: area } }, status: :ok

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

      #Search by job ID -> 'show' block
      job = StepJob.find_by(job_id: params[:id])
      return render json: { error: "Job not found" }, status: :not_found unless job

      #Format file path to always include extension if possible
      requested = [params[:filename], params[:format]].compact.join(".")
      file_path = Rails.root.join("storage","step_jobs", job.job_id, requested)
      return render json: { error: "File not found" }, status: :not_found unless File.exist?(file_path)

      #Tell browser that this is an image it can render (if true)
      ext  = File.extname(requested).downcase
      mime = (ext == ".svg") ? "image/svg+xml" : "application/octet-stream"

      #Send file
      send_file file_path, disposition: "inline", type: mime

    end

  end
end
