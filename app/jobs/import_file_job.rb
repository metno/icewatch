class ImportFileJob < ApplicationJob
  queue_as :default

  def perform(uploaded_file)
    uploaded_file.fetch! 
    uploaded_file.import!
  end

end
