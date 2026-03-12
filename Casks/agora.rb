cask "agora" do
  arch arm: "aarch64"

  version "0.3.2"
  sha256 arm: "2fbe3e6ce0a36c3c2bf6774bcb6732634be29a1e23a93a13d618bab2a0cf8217"

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
