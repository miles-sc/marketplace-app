require "securerandom"
require "fileutils"

class StepJob < ApplicationRecord
  BINARY_SCRIPT_DIR = Rails.root.parent.join("step_processing", "build")
  RENDER_SCRIPT_DIR = Rails.root.parent.join("step_processing", "step_render_views.py")
  CONDA_ENV = "cq"
  VALID_EXTENSIONS = [".step", ".stp"].freeze

  # Main method to process uploaded STEP files
  def self.process_upload(uploaded_file)
    return error_result("No file uploaded", :bad_request) if uploaded_file.nil?
    return error_result("Unsupported file type", :unprocessable_entity) unless valid_file?(uploaded_file)

    job_id = SecureRandom.uuid
    job_directory = storage_path_for(job_id)
    FileUtils.mkdir_p(job_directory)

    file_path = save_uploaded_file(uploaded_file, job_directory)
    metrics = calculate_metrics(file_path)
    generate_renders(file_path, job_directory)

    job = create!(
      job_id: job_id,
      filename: uploaded_file.original_filename.downcase,
      metrics: metrics
    )

    success_result(job)
  rescue StandardError => e
    error_result("Failed to process file: #{e.message}", :internal_server_error)
  end

  # Returns the storage directory path for a given job_id
  def self.storage_path_for(job_id)
    Rails.root.join("storage", "step_jobs", job_id)
  end

  # Instance method to get path for a specific file belonging to this job
  def file_path(filename)
    self.class.storage_path_for(job_id).join(filename)
  end

  # Determines MIME type based on file extension
  def self.mime_type_for(filename)
    ext = File.extname(filename).downcase
    ext == ".svg" ? "image/svg+xml" : "application/octet-stream"
  end

  private

  # Validates if uploaded file has correct extension
  def self.valid_file?(uploaded_file)
    return false unless uploaded_file&.original_filename

    filename = uploaded_file.original_filename.downcase
    VALID_EXTENSIONS.any? { |ext| filename.end_with?(ext) }
  end

  # Saves the uploaded file to disk
  def self.save_uploaded_file(uploaded_file, job_directory)
    file_path = job_directory.join(uploaded_file.original_filename.downcase)
    File.open(file_path, "wb") { |f| f.write(uploaded_file.read) }
    file_path
  end

  # Calculates volume and surface area using external binaries
  def self.calculate_metrics(file_path)
    volume = (`#{BINARY_SCRIPT_DIR.join("step_volume")} #{file_path}`.to_f / (25.4**3)).round(1)
    area = (`#{BINARY_SCRIPT_DIR.join("step_surface_area")} #{file_path}`.to_f / (25.4**2)).round(1)

    { volume: volume, surface_area: area }
  end

  # Generates render views using Python script
  def self.generate_renders(file_path, job_directory)
    `conda run -n #{CONDA_ENV} python #{RENDER_SCRIPT_DIR} #{file_path} #{job_directory}`
  end

  # Helper to create success result
  def self.success_result(job)
    {
      success: true,
      data: {
        job_id: job.job_id,
        filename: job.filename,
        metrics: job.metrics
      }
    }
  end

  # Helper to create error result
  def self.error_result(message, status)
    {
      success: false,
      error: message,
      status: status
    }
  end
end
