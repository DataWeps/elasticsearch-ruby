require 'spec_helper'

describe Elasticsearch::DSL::Search::Aggregations::DateRange do

  let(:search) do
    described_class.new
  end

  describe '#to_hash' do

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(date_range: {})
    end
  end

  context 'when options methods are called' do

    let(:search) do
      described_class.new(:foo)
    end

    describe '#field' do

      before do
        search.field('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:date_range][:foo][:field]).to eq('bar')
      end
    end

    describe '#format' do

      before do
        search.format('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:date_range][:foo][:format]).to eq('bar')
      end
    end

    describe '#ranges' do

      before do
        search.ranges('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:date_range][:foo][:ranges]).to eq('bar')
      end
    end
  end

  describe '#initialize' do

    context 'when a block is provided' do

      let(:search) do
        described_class.new do
          field 'bar'
          ranges [ {to: 'foo'}, {from: 'bar'} ]
        end
      end

      it 'executes the block' do
        expect(search.to_hash).to eq(date_range: { field: 'bar', ranges: [ {to: 'foo'}, {from: 'bar'} ] })
      end
    end
  end
end
