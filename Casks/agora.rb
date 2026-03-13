cask "agora" do
  arch arm: "aarch64"

  version "0.3.3"
  sha256 arm: "941e0430e3c48e20205e56320a922185f188e61e4c4348a3e5d8f45f5a0eb90e"

  url "https://github.com/StressTestor/Agora-ai-agent-visualizer/releases/download/v#{version}/agora_#{version}_#{arch}.dmg"
  name "Agora"
  desc "Multi-model AI agent debate visualizer for Claude Code teams"
  homepage "https://github.com/StressTestor/Agora-ai-agent-visualizer"

  preflight do
    # remove existing app (handles manual installs that brew doesn't track)
    app_path = "/Applications/agora.app"
    if Dir.exist?(app_path)
      system_command "/usr/bin/osascript", args: ["-e", 'quit app "agora"'], print_stderr: false
      FileUtils.rm_rf(app_path)
    end

    # clear Tauri WebKit cache so upgrades pick up new frontend assets
    %w[
      ~/Library/WebKit/dev.notbatman.agora
      ~/Library/Caches/dev.notbatman.agora
      ~/Library/Application\ Support/dev.notbatman.agora
      ~/Library/Saved\ Application\ State/dev.notbatman.agora.savedState
    ].each do |dir|
      path = File.expand_path(dir)
      FileUtils.rm_rf(path) if Dir.exist?(path)
    end
  end

  app "agora.app"

  zap trash: [
    "~/.config/agora",
    "~/Library/WebKit/dev.notbatman.agora",
    "~/Library/Caches/dev.notbatman.agora",
    "~/Library/Application Support/dev.notbatman.agora",
    "~/Library/Saved Application State/dev.notbatman.agora.savedState",
  ]
end
