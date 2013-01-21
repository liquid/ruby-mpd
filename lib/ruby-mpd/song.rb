class MPD; end

# This class is a glorified Hash used to represent a song.
#
# If the field doesn't exist or isn't set, nil will be returned
class MPD::Song
  # length in seconds
  attr_accessor :time

  def initialize(options)
    @data = {} #allowed fields are @types + :file
    @time = options.delete(:time).first #HAXX for array return
    @data.merge! options
  end

  # Two songs are the same when they are the same file.
  def ==(another)
    self.file == another.file
  end

  def length
    return "#{(@time / 60)}:#{"%02d" % (@time % 60)}"
  end

  def method_missing(m, *a)
    key = m #.to_s
    if key =~ /=$/
      @data[$`] = a[0]
    elsif a.empty?
      @data[key]
    else
      raise NoMethodError, "#{m}"
    end
  end
end