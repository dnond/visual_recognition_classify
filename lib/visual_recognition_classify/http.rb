require 'curb'
require 'json'

module VisualRecognitionClassify
  class Http
    class << self
      def get(url)
        result = Curl.get(url)
        parse_body(result.body)
      end

      def delete(url)
        result = Curl.delete(url)
        parse_body(result.body)
      end

      def form_post(url, params)
        client = Curl::Easy.new(url)
        client.multipart_form_post = true
        client.http_post(form_post_params(params))
        parse_body(client.body)
      end

      def form_post_params(params)
        [].tap do |post_params|
          post_params << Curl::PostField.content('name', params['name']) if params['name']

          params.reject { |key, val|
            key == 'name'
          }.each { |key, val|
            post_params << Curl::PostField.file(key, val)
          }
        end
      end

      def parse_body(body)
        JSON.parse body
      rescue TypeError, JSON::ParserError
        return body
      end
    end
  end
end
