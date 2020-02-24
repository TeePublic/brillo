module Brillo
  class File
    attr_reader :filename, :associations

    DEFAULT_OPTIONS = {
      filename: nil,
      include_schema: true,
      recreate_on_import: true,
      compress: false,
      extension: 'dmp'
    }.freeze

    def initialize(namespace, options = {})
      options = DEFAULT_OPTIONS.merge(options)
      @namespace =          namespace
      @extension =          options[:extension]
      @filename =           options[:filename]
      @associations =       options[:explore]
      @include_schema =     options[:include_schema]
      @recreate_on_import = options[:recreate_on_import]

      @extension += '.gz' if options[:compress]
    end

    def include_schema?
      @include_schema
    end

    def recreate_on_import?
      @recreate_on_import
    end

    def full_filename
      path = [@namespace]
      path << @filename if @filename
      path << 'scrubbed'
      "#{path.join('-')}.#{@extension}"
    end
  end
end