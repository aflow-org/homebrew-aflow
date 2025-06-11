class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.0.4/aflow_4.0.4.orig.tar.gz"
  sha256 "5d7aaf44f3cf3ee34424042af373d2f7f30689f7d1f681237a0fd0d24cefe82f"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/aflow-org/aflow"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "4858aceb4a5821482e02b88e6bd7c2e392ffc1b3696ffcaad753a15961056678"
    sha256 cellar: :any,                 ventura:       "33f240a5d74e83e90f40a92ab0eb20779c3404b85a11a1e884738bd83dd0ad36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92e1fdfbc01adad48a17f0f1932f5c36c0687602fb9f772f9cdc84c550d5f7c9"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "curl"
  depends_on "libarchive"
  depends_on "openssl@3"
  def install
    system "cmake", "-S", "./src/", "--preset", "release", *std_cmake_args
    system "cmake", "--build", "build/release"
    system "cmake", "--install", "build/release"
  end

  test do
    shell_output("#{bin}/aflow --unit_test aurostd 2>&1")
  end
end
