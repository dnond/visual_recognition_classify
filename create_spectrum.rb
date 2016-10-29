require 'pry'


def create_spectrum_via(dir)
  files = Dir.glob "#{dir}/*"

  files.select do |file|
    file.include?('.mp3') || file.include?('.wav')
  end.each do |file|
    puts "start: #{file}"
    `sox "#{file}" -n spectrogram -o "#{file}.png" -r -h`
  end
end

mp3dir = ARGV[0]
create_spectrum_via mp3dir

puts 'end!'
