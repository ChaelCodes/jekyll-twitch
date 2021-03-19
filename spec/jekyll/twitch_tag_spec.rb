require "pry"

RSpec.describe Jekyll::TwitchTag do
  it "has a version number" do
    expect(Jekyll::Twitch::VERSION).not_to be nil
  end

  describe '.parse_twitch_url' do
    subject { Jekyll::TwitchTag.parse_twitch_url(url) }

    context 'with clip urls' do
      let(:url) { 'https://www.twitch.tv/chaelcodes/clip/NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z' }

      it { is_expected.to eq 'https://clips.twitch.tv/embed?autoplay=false&clip=NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z' }
    end
  end

  describe '#render' do
    subject { Jekyll::TwitchTag }
    before do
      allow(Jekyll::TwitchTag).to receive(:site_host).and_return("test")
    end

    it "renders a twitch embed" do
      tag = Liquid::Template.parse("{% twitch https://www.twitch.tv/chaelcodes/clip/NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z %}")
      liquid = tag.render
      expect(liquid).to eq(
      %Q{<iframe
        src="https://clips.twitch.tv/embed?autoplay=false&clip=NurturingEphemeralLegKreygasm-pZLTOLAGhV8sHP7Z&parent=test"
        height="720"
        width="1280"
        allowfullscreen="true">
      </iframe>}
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
