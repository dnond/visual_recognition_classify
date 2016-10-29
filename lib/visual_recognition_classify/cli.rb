require 'thor'

module VisualRecognitionClassify
  class CLI < Thor
    class_option :debug, type: :boolean

    desc 'create_classifier_id', 'create classifier_id for custom class'
    method_option :class_name,         default: nil, desc: 'class name for create'
    method_option :positive_image_dir, default: nil, desc: 'positive image directory file path'
    method_option :negative_image_dir, default: nil, desc: 'negative image directory file path'
    def create_classifier_id
      VisualRecognitionClassify.create_classifier_id(*options.values)
    end

    desc 'learn', 'add positive and negative images to learn'
    method_option :classifier_id,      default: nil, desc: 'classifier_id to learn'
    method_option :positive_image_dir, default: nil, desc: 'positive image directory file path'
    method_option :negative_image_dir, default: nil, desc: 'negative image directory file path'
    def learn
      VisualRecognitionClassify.learn(*options.values)
    end

    desc 'classifier_detail', 'show detail for specified classifier_id'
    method_option :classifier_id, default: nil, desc: 'classifier_id'
    def classifier_detail
      classifier_id = options[:classifier_id]
      VisualRecognitionClassify.classifier_detail(classifier_id)
    end

    desc 'delete_classifier', 'delete specified classifier_id'
    method_option :classifier_id, default: nil, desc: 'classifier_id'
    def delete_classifier
      classifier_id = options[:classifier_id]
      VisualRecognitionClassify.delete_classifier(classifier_id)
    end

    desc 'show classifiers list', 'show defined classifiers list'
    def classifiers
      VisualRecognitionClassify.classifiers
    end

    desc 'classify specified image', 'classify specified image'
    method_option :classifier_id, default: nil, desc: 'classifier_id'
    method_option :file_path,    default: nil, desc: 'image file or dir path'
    def classify
      classifier_id = options[:classifier_id]
      file_path     = options[:file_path]
      if FileTest.directory?(file_path)
        image_files = Dir.glob("#{file_path}/*")
      else
        image_files = [file_path]
      end

      results = image_files.map do |image_file|
        if ::File.basename(image_file).end_with?('png', 'jpg')
          VisualRecognitionClassify.classify([classifier_id], image_file)
        end
      end

      puts results
    end

    desc 'classify images in specific dir', 'classify images in specified dir'
    method_option :classifier_id, default: nil, desc: 'classifier_id'
    method_option :image_file_dir,    default: nil, desc: 'image dir path'
    def classify_dir
      classifier_id  = options[:classifier_id]
      image_file_dir = options[:image_file_dir]

      results = []
      Dir.glob("#{image_file_dir}/*").each do |image_file|
        results << VisualRecognitionClassify.classify([classifier_id], image_file)
      end
      puts results
    end
  end
end

