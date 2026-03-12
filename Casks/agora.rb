cask "agora" do
  arch arm: "aarch64"

  version "0.3.0"
  sha256 arm: "c984be8558db7bf944c3dca397be3923f44c1441cd57846b8d22ec947bfc8007"

  url "https://github.com/StressTestor/Agora-ai-agent-visualizer/releases/download/v#{version}/agora_#{version}_#{arch}.dmg"
  name "Agora"
  desc "Multi-model AI agent debate visualizer for Claude Code teams"
  homepage "https://github.com/StressTestor/Agora-ai-agent-visualizer"

  app "agora.app"

  zap trash: [
    "~/.config/agora",
    "~/Library/WebKit/dev.notbatman.agora",
    "~/Library/Caches/dev.notbatman.agora",
    "~/Library/Application Support/dev.notbatman.agora",
    "~/Library/Saved Application State/dev.notbatman.agora.savedState",
  ]
end
