module VisualRecognitionClassify
  class ClassifyApi < Api
    def run(classifier_ids, image_file)
      post 'classify', params(image_file), params_for_get: params_for_get(classifier_ids)
    end

    private

    def params_for_get(classifier_ids)
      {
        'classifier_ids' => classifier_ids.class == Array ? classifier_ids.join(',') : classifier_ids,
        'owners'         => 'me,IBM',
        'threshold'      => '0.0'
      }
    end

    def params(image_file)
      { 'images_file' => image_file }
    end
  end
end

