// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Demo",
  platforms: [
    .iOS(.v13),
  ],
  products: [
    .library(name: "Demo", targets: ["Demo"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", .upToNextMajor(from: "0.1.0")),
  ],
  targets: [
    .target(
      name: "Demo",
      dependencies: [
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
      ],
      path: "Sources"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
