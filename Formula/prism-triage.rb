class PrismTriage < Formula
  desc "Triage tool for repos drowning in PRs — find dupes, rank quality, check vision alignment"
  homepage "https://github.com/StressTestor/pr-prism"
  url "https://github.com/StressTestor/pr-prism/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "b0711ba638dc4004673f20b748c46914d67f50c181def6aa59eea2ff072438f4"
  license "MIT"

  depends_on "node@20"

  def install
    system "npm", "install", *std_npm_args, "--production=false"
    system "npm", "run", "build"

    # Install production deps into libexec
    libexec.install Dir["*"]
    cd libexec do
      system "npm", "prune", "--production"
    end

    # Create wrapper script that calls node with the compiled CLI
    (bin/"prism").write <<~SH
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism --version").strip
    assert_match "prism", shell_output("#{bin}/prism --help")
  end
end
