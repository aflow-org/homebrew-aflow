class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.0.4/aflow_4.0.4.orig.tar.gz"
  sha256 "5d7aaf44f3cf3ee34424042af373d2f7f30689f7d1f681237a0fd0d24cefe82f"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/aflow-org/tap_test"
    sha256 cellar: :any,                 arm64_sequoia: "8435d04d68300645e001d4f43c8182f0a8c42e98fe971351345e12147f63d97f"
    sha256 cellar: :any,                 ventura:       "a1d65e547e1b5dc86995867872abb48b966ac7a223981064fef3771dc252ea59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f140246385917b3bc3d67d5ff6f3dd5c88a90167c7e3f6e9dcd9f7758b956ae6"
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
