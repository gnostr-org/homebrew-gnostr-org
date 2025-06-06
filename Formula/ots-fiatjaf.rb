class OtsFiatjaf < Formula
  desc "OpenTimestamps CLI"
  homepage "https://github.com/fiatjaf/ots"
  url "https://github.com/fiatjaf/ots.git",
      tag:      "v0.2.3",
      revision: "8b29c6252c0b669161958f9beffea2ca18667064"
  head "https://github.com/fiatjaf/ots.git", branch: "master"

  depends_on "go" => :build

  conflicts_with "ots"

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(output: bin/"ots")
  end

  test do
    system "#{bin}/ots", "-h"
  end
end
