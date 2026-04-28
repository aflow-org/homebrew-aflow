class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.1/aflow_4.1_orig.tar.gz"
  sha256 "3711ed521e97c8a005d89720a4d990930ab3d928f5d2bf718a713c0d0e0f3d0a"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/aflow-org/aflow"
    sha256 cellar: :any,                 arm64_tahoe:   "d7a2b53a25d93a64962641544f832f2c5176786836128fee68214593d4d54952"
    sha256 cellar: :any,                 arm64_sequoia: "124818a15e33613cf4c870318660455ec3d7182de4ed98dbc5a3d94087404b3f"
    sha256 cellar: :any,                 arm64_sonoma:  "67c0978e958b57826bb7d36125916bb7aa1dcba088d76b6a8f7000eb409fa735"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9594a7a8d6f935d61ac1ef04ba6c0076ea1c81dd05c2aa8352607024c83d26d"
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
