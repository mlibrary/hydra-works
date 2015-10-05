module Hydra::Works::GenericFile::Characterization
  module Video
    extend ActiveSupport::Concern

    autoload :VideoSchema, 'hydra/works/models/generic_file/characterization/video_schema.rb'

    included do
      # Apply the module schema. This will add properties defined in the schema.
      apply_schema VideoSchema, AlreadyThereStrategy

      # Update the configuration to map the parsed terms to the correct property.
      parser_mapping.merge!(video_sample_rate: :sample_rate,
                            video_audio_sample_rate: :sample_rate,
                            video_duration: :duration,
                            video_width: :width,
                            video_height: :height)
    end
  end
end