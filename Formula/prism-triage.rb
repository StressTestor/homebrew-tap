class PrismTriage < Formula
  desc "Triage tool for repos drowning in PRs — find dupes, rank quality, check vision alignment"
  homepage "https://github.com/StressTestor/pr-prism"
  url "https://github.com/StressTestor/pr-prism/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "b0711ba638dc4004673f20b748c46914d67f50c181def6aa59eea2ff072438f4"
  license "MIT"

  depends_on "node"

  def install
    # Install all deps (including devDeps for tsc)
    system "npm", "ci"
    # Build TypeScript
    system "npm", "run", "build"
    # Prune devDeps
    system "npm", "prune", "--production"

    # Install everything into libexec
    libexec.install Dir["dist", "node_modules", "package.json", "prism.config.yaml", ".env.example"]

    # Create wrapper script
    node = Formula["node"].opt_bin/"node"
    (bin/"prism").write <<~SH
      #!/bin/bash
      exec "#{node}" "#{libexec}/dist/cli.js" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism --version").strip
    assert_match "prism", shell_output("#{bin}/prism --help")
  end
end
