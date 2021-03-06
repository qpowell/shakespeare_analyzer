require_relative '../lib/shakespeare_analyzer.rb'

describe ShakespeareAnalyzer do
  let(:analyzer) { ShakespeareAnalyzer.new(@xml) }

  describe '#run' do
    it 'returns an empty hash if there is no data to parse' do
      @xml = ""
      expect(analyzer.run).to eq({})
    end

    it 'counts the number of lines a speaker has in a speech' do
      @xml = <<-eof
        <SPEECH>
          <SPEAKER>First Witch</SPEAKER>
          <LINE>When shall we three meet again</LINE>
          <LINE>In thunder, lightning, or in rain?</LINE>
        </SPEECH>
      eof

      expect(analyzer.run).to eq({'First Witch' => 2})
    end

    it 'counts the lines for multiple speakers in a speech' do
      @xml = <<-eof
        <SPEECH>
          <SPEAKER>MACBETH</SPEAKER>
          <SPEAKER>LENNOX</SPEAKER>
          <LINE>What's the matter.</LINE>
        </SPEECH>
      eof

      expect(analyzer.run).to eq({'MACBETH' => 1, 'LENNOX' => 1})
    end
  end
end