require "securerandom"
require "fileutils"

module Api
  class StepJobsController < ApplicationController
    BINARY_SCRIPT_DIR= Rails.root.parent.join("step_processing","build")
    RENDER_SCRIPT_DIR= Rails.root.parent.join("step_processing","step_render_views.py")
    RENDER_CACHE_DIR= Rails.root.parent.join("step_processing","render_cache")

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
      job_directory= Rails.root.join("tmp","step_jobs",job_id)
      FileUtils.mkdir_p(job_directory)

      destination= job_directory.join(uploaded_file.original_filename.downcase)
      File.open(destination, "wb") { |f| f.write(uploaded_file.read) }

      volume = `#{BINARY_SCRIPT_DIR.join("step_volume")} #{destination}`.to_f
      area   = `#{BINARY_SCRIPT_DIR.join("step_surface_area")} #{destination}`.to_f

      `python3 #{RENDER_SCRIPT_DIR} #{destination}`

      iso=RENDER_CACHE_DIR.join("iso.svg")
      front=RENDER_CACHE_DIR.join("front.svg")
      top=RENDER_CACHE_DIR.join("top.svg")

      FileUtils.cp(iso, job_directory.join("iso.svg"))
      FileUtils.cp(front, job_directory.join("front.svg"))
      FileUtils.cp(top, job_directory.join("top.svg"))


      render json: {
        job_id: job_id,
        filename: uploaded_file.original_filename,
        metrics: {
          volume: volume,
          surface_area: area
        }
      }, status: :ok
    end
  end
end
