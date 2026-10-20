cask "dropkeeper" do
  version "1.0.2"
  sha256 "85d66c4a7f4224c6cc5efb21742e0ba3805f8914cd4ca2ca2d98024cc708fb73"

  url "https://github.com/direcat/dropkeeper/releases/download/v#{version}/DropKeeper-#{version}.zip"
  name "DropKeeper"
  desc "Gives every download an expiry and moves expired files to the Trash"
  homepage "https://github.com/direcat/dropkeeper"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "DropKeeper.app"

  # DropKeeper is not notarized (no paid Apple Developer account). Remove the
  # quarantine attribute so macOS does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/DropKeeper.app"]
  end

  uninstall quit:       "net.direcat.dropkeeper",
            login_item: "DropKeeper"

  zap trash: [
    "~/Library/Application Support/DropKeeper",
    "~/Library/Preferences/net.direcat.dropkeeper.plist",
  ]
end
