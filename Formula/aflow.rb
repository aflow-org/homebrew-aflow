class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.0.5/aflow_4.0.5.orig.tar.gz"
  sha256 "4b250edf96f5318fc8588321a7778e5e271616d6cad3b4cc405a6cacb4c95b19"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/aflow-org/aflow"
    sha256 cellar: :any,                 arm64_sequoia: "e7e27316dea3c62468613f36174b6fcda09fe3d838a18a559116b045da7f38eb"
    sha256 cellar: :any,                 ventura:       "bcd4ae56dfd19c31b8d467be7b29cb0480fb9cd3622b6e94617906b1425021ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "920ef0e8f5ff6a71fd31b1bfa11a0aa87ea123e13291c98635af3d5bc96f9967"
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
