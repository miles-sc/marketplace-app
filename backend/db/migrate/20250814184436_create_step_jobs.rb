class CreateStepJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :step_jobs do |t|
      t.string :job_id
      t.string :filename
      t.jsonb :metrics

      t.timestamps
    end
    add_index :step_jobs, :job_id, unique: true
  end
end
