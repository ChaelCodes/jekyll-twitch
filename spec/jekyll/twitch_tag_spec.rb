# frozen_string_literal: true

require 'pry'

RSpec.describe Jekyll::TwitchTag do
  it 'has a version number' do
    expect(Jekyll::Twitch::VERSION).not_to be nil
  end

  describe '.hostname' do
    subject { described_class.hostname(url) }

    context 'with development' do
      let(:url) { 'localhost:4000' }

      it { is_expected.to eq 'localhost' }

      context 'with base url' do
        let(:url) { 'https://localhost:4000/base' }

        it { is_expected.to eq 'localhost' }
      end
    end

    context 'with production' do
      let(:url) { 'https://chael.codes' }

      it { is_expected.to eq 'chael.codes' }
    end

    context 'with base url' do
      let(:url) { 'https://chael.codes/base' }

      it { is_expected.to eq 'chael.codes' }
    end
  end

  describe '.parse_twitch_url' do
    subject { described_class.parse_twitch_url(url) }

    context 'with clip urls' do
      let(:url) { 'https://www.twitch.tv/chaelcodes/clip/LongClipName-uuid1234' }

      it {
        is_expected.to eq 'https://clips.twitch.tv/embed?autoplay=false&clip=LongClipName-uuid1234'
      }
    end
  end

  describe '#render' do
    subject { described_class }

    before do
      allow(described_class).to receive(:site_url).and_return('test')
    end

    let(:tag) { Liquid::Template.parse('{% twitch https://www.twitch.tv/chaelcodes/clip/LongClipName-uuid1234 %}') }

    it 'renders a twitch embed' do # rubocop:disable RSpec/ExampleLength
      liquid = tag.render
      expect(liquid).to eq(
        %(<iframe
        src="https://clips.twitch.tv/embed?autoplay=false&clip=LongClipName-uuid1234&parent=test"
        height="720"
        width="1280"
        allowfullscreen="true">
      </iframe>)
      ) # https://player.twitch.tv/?
    end
  end

  # describe 'rendering on a page' do
  #   let(:doc) { doc_with_content(content) }
  #   let(:content) { "{% gist #{gist} %}" }
  #   let(:output) do
  #     doc.content = content
  #     doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  #   end
  # end
end
