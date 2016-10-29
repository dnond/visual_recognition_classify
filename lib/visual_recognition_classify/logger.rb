require 'logger'

module VisualRecognitionClassify
  class Logger
    def debug(message)
      @logger ||= ::Logger.new(STDOUT)
      @logger.debug(message)
    end

    def error(message)
      @logger ||= ::Logger.new(STDERR)
      @logger.error(message)
    end
  end
end
