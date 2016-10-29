require 'uri'
require "addressable/uri"

module VisualRecognitionClassify
  class Api
    def post(action, params, params_for_get: nil, classifier_id: nil)
      url = url_for(action, classifier_id)
      url = "#{url}&#{convert_to_query(params_for_get)}" if params_for_get
      VisualRecognitionClassify.debug("post to #{url}")
      VisualRecognitionClassify.debug("params to #{params}")

      result = Http.form_post(url, params)
      VisualRecognitionClassify.debug("result for #{url} : #{result}")
      result
    end

    def get(action, classifier_id: nil, params: nil)
      url = url_for(action, classifier_id)
      url = "#{url}&#{convert_to_query(params)}" if params
      VisualRecognitionClassify.debug("get to #{url}")

      result = Http.get(url)
      VisualRecognitionClassify.debug("result for #{url} : #{result}")
      result
    end

    def delete(action, classifier_id:)
      url = url_for(action, classifier_id)
      VisualRecognitionClassify.debug("delete to #{url}")

      result = Http.delete(url)
      VisualRecognitionClassify.debug("result for #{url} : #{result}")
      result
    end

    def convert_to_query(params)
      uri = Addressable::URI.new
      uri.query_values = params
      uri.query
    end

    private

    def url_for(action, target = nil)
      target_ = target.nil? ? '' : "/#{target}"
      "https://gateway-a.watsonplatform.net/visual-recognition/api/#{api_version}/#{action}#{target_}?api_key=#{api_key}&version=#{post_version}"
    end

    def api_version
      "v3"
    end

    def api_key
      ENV['VISUAL_RECOGNITION_API_KEY'] || ''
    end

    def post_version
      DateTime.now.strftime("%F-%T")
    end
  end
end
