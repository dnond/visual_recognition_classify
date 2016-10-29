module VisualRecognitionClassify
  class ClassifiersApi < Api
    # classifier_idの作成
    def create(class_name, zipped_postive, zipped_negative = nil)
      post 'classifiers', create_params(class_name, zipped_postive, zipped_negative)
    end

    def learn(classifier_id, zipped_postive, zipped_negative = nil)
      class_name = classifier_id.split('_').first
      post 'classifiers', create_params(class_name, zipped_postive, zipped_negative), classifier_id: classifier_id
    end

    def list
      get 'classifiers'
    end

    def detail(classifier_id)
      get 'classifiers', classifier_id: classifier_id
    end

    def remove(classifier_id)
      delete 'classifiers', classifier_id: classifier_id
    end

    private

    def create_params(class_name, zipped_positive, zipped_negative)
      {}.tap do |params|
        params['name'] = class_name
        params["#{class_name}_positive_examples"] =  zipped_positive
        params['negative_examples'] = zipped_negative unless zipped_negative.nil?
      end
    end
  end
end

