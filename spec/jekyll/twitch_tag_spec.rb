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

    context 'with channel url' do
      let(:url) { 'https://twitch.tv/ChaelCodes' }

      it {
        is_expected.to eq 'https://player.twitch.tv/?channel=ChaelCodes&autoplay=false'
      }
    end

    context 'with vod url' do
      let(:url) { 'https://www.twitch.tv/videos/716698136' }

      it {
        is_expected.to eq 'https://player.twitch.tv/?video=716698136&autoplay=false'
      }

      context 'with messy url' do
        let(:url) { 'https://www.twitch.tv/videos/716698136?filter=highlights&sort=views' }

        it {
          is_expected.to eq 'https://player.twitch.tv/?video=716698136&autoplay=false'
        }
      end
    end
  end

  describe '#render' do
    subject { described_class }

    before do
      allow(described_class).to receive(:site_url).and_return('test')
    end

    context 'with clip' do
      let(:tag) { Liquid::Template.parse('{% twitch https://www.twitch.tv/chaelcodes/clip/LongClipName-uuid1234 %}') }
      let(:result) do
      # rubocop:disable Layout/IndentationWidth
      %(<iframe
        src="https://clips.twitch.tv/embed?autoplay=false&clip=LongClipName-uuid1234&parent=test"
        height="100%"
        width="100%"
        allowfullscreen="true">
      </iframe>)
        # rubocop:enable Layout/IndentationWidth
      end

      it 'renders a twitch embed' do
        liquid = tag.render
        expect(liquid).to eq result
      end
    end

    context 'with channel' do
      let(:tag) { Liquid::Template.parse('{% twitch https://twitch.tv/ChaelCodes %}') }
      let(:result) do
      # rubocop:disable Layout/IndentationWidth
      %(<iframe
        src="https://player.twitch.tv/?channel=ChaelCodes&autoplay=false&parent=test"
        height="100%"
        width="100%"
        allowfullscreen="true">
      </iframe>)
        # rubocop:enable Layout/IndentationWidth
      end

      it 'renders a twitch embed' do
        liquid = tag.render
        expect(liquid).to eq result
      end
    end

    context 'with VoD' do
      let(:tag) { Liquid::Template.parse('{% twitch https://www.twitch.tv/videos/716698136 %}') }
      let(:result) do
      # rubocop:disable Layout/IndentationWidth
      %(<iframe
        src="https://player.twitch.tv/?video=716698136&autoplay=false&parent=test"
        height="100%"
        width="100%"
        allowfullscreen="true">
      </iframe>)
        # rubocop:enable Layout/IndentationWidth
      end

      it 'renders a twitch embed' do
        liquid = tag.render
        expect(liquid).to eq result
      end
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
