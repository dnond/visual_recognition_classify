require "visual_recognition_classify/local_file"
require "visual_recognition_classify/http"
require "visual_recognition_classify/logger"
require "visual_recognition_classify/api"
require "visual_recognition_classify/classifiers_api"
require "visual_recognition_classify/classify_api"
require "visual_recognition_classify/cli"

module VisualRecognitionClassify
  class << self
    extend Forwardable
    def_delegators :logger, :debug, :error
    def_delegators :file, :zip

    def create_classifier_id(class_name, positive_image_dir, negative_image_dir)
      zipped_postive  = zip(positive_image_dir)
      zipped_negative = zip(negative_image_dir)

      ClassifiersApi.new.create(class_name, zipped_postive, zipped_negative)
    end

    def learn(classifier_id, positive_image_dir, negative_image_dir)
      zipped_postive  = zip(positive_image_dir)
      zipped_negative = zip(negative_image_dir)

      ClassifiersApi.new.learn(classifier_id, zipped_postive, zipped_negative)
    end

    def classifiers
      ClassifiersApi.new.list
    end

    def classifier_detail(classifier_id)
      ClassifiersApi.new.detail(classifier_id)
    end

    def delete_classifier(classifier_id)
      ClassifiersApi.new.remove(classifier_id)
    end

    def classify(classifier_ids, file_path)
      ClassifyApi.new.run(classifier_ids, file_path)
    end

    def logger
      @logger ||= ::VisualRecognitionClassify::Logger.new
    end

    def file
      @file ||= ::VisualRecognitionClassify::LocalFile.new
    end
  end
end
