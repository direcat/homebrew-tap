cask "dropkeeper" do
  version "1.0.1"
  sha256 "e83d37e6029b5608eacda7def67cf68f11c52bed851795c328532bcfd70d8ed2"

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
