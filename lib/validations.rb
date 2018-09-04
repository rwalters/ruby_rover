require "pathname"

module Validations
  class ValidationError < StandardError;end

  class << self
    def check(**args)
      validations.each{|v| v.validate(args) }
    rescue StandardError => e
      raise ValidationError.new(e.message)
    end

    def validations
      @registered_validations ||= []
    end

    def register(klass)
      validations << klass.new.freeze
    end
  end

  dir = File.expand_path('validations', __dir__)
  $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

  files = Pathname(dir).each_child.map{|f| f.basename('.rb')}
  files.each do |file|
    p file.to_s
    require file.to_s
  end
end
