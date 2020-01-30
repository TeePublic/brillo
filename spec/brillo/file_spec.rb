require 'spec_helper'

RSpec.describe Brillo::File do
  let(:opts) {
    {
      filename: 'seedfile',
      include_schema: false,
      recreate_on_import: false
    }
  }

  let(:file){
    Brillo::File.new('namespace', opts)
  }

  describe '#initialize' do
    it 'accepts a custom filename' do
      expect(file.filename).to eq(opts[:filename])
    end

    it 'accepts a include_schema flag' do
      expect(file.include_schema?).to eq(false)
    end

    it 'accepts a recreate_on_import flag' do
      expect(file.recreate_on_import?).to eq(false)
    end
  end

  describe '#filename' do
    it 'returns a filepath with extension' do
      expect(file.full_filename).to eq('namespace-seedfile-scrubbed.dmp')
    end

    it 'returns a filepath with compression extension' do
      file = Brillo::File.new('namespace', opts.merge(compress: true))
      expect(file.full_filename).to eq('namespace-seedfile-scrubbed.dmp.gz')
    end
  end
end