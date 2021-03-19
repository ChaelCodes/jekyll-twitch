# frozen_string_literal: true

require 'pry'

RSpec.describe Jekyll::TwitchTag do # rubocop:disable Metrics/BlockLength
  it 'has a version number' do
    expect(Jekyll::Twitch::VERSION).not_to be nil
  end

  describe '.parse_twitch_url' do
    subject { described_class.parse_twitch_url(url) }

    context 'with clip urls' do
      let(:url) { 'https://www.twitch.tv/chaelcodes/clip/NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z' }

      it {
        is_expected.to eq 'https://clips.twitch.tv/embed?autoplay=false&clip=NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z'
      }
    end
  end

  describe '#render' do
    subject { described_class }

    let(:clip_slug) { 'NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z' }
    let(:embed) do
      %(<iframe
        src="https://clips.twitch.tv/embed?autoplay=false&clip=#{clip_slug}&parent=test"
        height="720"
        width="1280"
        allowfullscreen="true">
      </iframe>)
    end

    before do
      allow(described_class).to receive(:site_host).and_return('test')
    end

    it 'renders a twitch embed' do
      tag = Liquid::Template.parse(
        "{% twitch https://www.twitch.tv/chaelcodes/clip/#{clip_slug} %}"
      )
      liquid = tag.render
      expect(liquid).to eq(embed) # https://player.twitch.tv/?
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
