class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.1/aflow_4.1_orig.tar.gz"
  sha256 "3711ed521e97c8a005d89720a4d990930ab3d928f5d2bf718a713c0d0e0f3d0a"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/aflow-org/aflow"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "c652c002c421062a31bca485223de13b104328c249076c91176d6a91f4380d40"
    sha256 cellar: :any,                 arm64_sequoia: "399cf4204fc0dd6a0e7ab07ab265f0360d73f9da6e1edb1c41d72b5752717c75"
    sha256 cellar: :any,                 arm64_sonoma:  "8948642ac114d847a4449b65e406cfe5b20ee2785dfb577d5b302879089863a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1bac00a88ef000753190226120ef1d5490a9db425873b48e274a5cc6e04a72ea"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "curl"
  depends_on "libarchive"
  depends_on "openssl@3"
  def install
    ENV["AFLOW_RELEASE"] = "true"
    system "cmake", "-S", "./src/", "--preset", "release", *std_cmake_args
    system "cmake", "--build", "build/release"
    system "cmake", "--install", "build/release"
  end

  test do
    shell_output("#{bin}/aflow --unit_test aurostd 2>&1")
  end
end
