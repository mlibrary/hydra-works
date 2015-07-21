# This was taken directly from Sufia's GenericFile::MimeTypes
module Hydra::Works::GenericFile
  module MimeTypes
    extend ActiveSupport::Concern

    def pdf?
      self.class.pdf_mime_types.include? mime_type
    end

    def image?
      self.class.image_mime_types.include? mime_type
    end

    def video?
      self.class.video_mime_types.include? mime_type
    end

    def audio?
      self.class.audio_mime_types.include? mime_type
    end

    def office_document?
      self.class.office_document_mime_types.include? mime_type
    end

    # TODO: remove?
    def collection?
      false
    end

    def file_format
      if mime_type.present? && format_label.present?
        "#{mime_type.split('/').last} (#{format_label.join(", ")})"
      elsif mime_type.present?
        mime_type.split('/').last
      elsif format_label.present?
        format_label
      else
        nil
      end
    end

    module ClassMethods
      def image_mime_types
        ['image/png', 'image/jpeg', 'image/jpg', 'image/jp2', 'image/bmp', 'image/gif', 'image/tiff']
      end

      def pdf_mime_types
        ['application/pdf']
      end

      def video_mime_types
        ['video/mpeg', 'video/mp4', 'video/webm', 'video/x-msvideo', 'video/avi', 'video/quicktime', 'application/mxf']
      end

      def audio_mime_types
        # audio/x-wave is the mime type that fits 0.6.0 returns for a wav file.
        # audio/mpeg is the mime type that fits 0.6.0 returns for an mp3 file.
        ['audio/mp3', 'audio/mpeg', 'audio/wav', 'audio/x-wave', 'audio/x-wav', 'audio/ogg']
      end

      def office_document_mime_types
        ['text/rtf',
         'application/msword',
         'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
         'application/vnd.oasis.opendocument.text',
         'application/vnd.ms-excel',
         'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
         'application/vnd.ms-powerpoint',
         'application/vnd.openxmlformats-officedocument.presentationml.presentation']
      end
    end
  end
end
