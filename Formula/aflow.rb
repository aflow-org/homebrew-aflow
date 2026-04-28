class Aflow < Formula
  desc "Automatic FLOW for Materials Discovery"
  homepage "https://aflow.org"
  url "https://github.com/aflow-org/aflow/releases/download/v4.1/aflow_4.1_orig.tar.gz"
  sha256 "3711ed521e97c8a005d89720a4d990930ab3d928f5d2bf718a713c0d0e0f3d0a"
  license "GPL-3.0-only"

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
