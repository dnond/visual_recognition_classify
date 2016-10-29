module VisualRecognitionClassify
  class LocalFile
    WORKDIR = '/tmp/visual_recognitin_classify/'

    def zip(dir)
      archive = "#{workdir}#{::File.basename(dir)}.zip"
      `cd "#{dir}" && zip "#{archive}" ./* && cd -`
      archive
    end

    private

    def workdir
      FileUtils.mkdir_p(WORKDIR) unless ::File.exist? WORKDIR
      WORKDIR
    end
  end
end
