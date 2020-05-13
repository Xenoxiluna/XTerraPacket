// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XTerraPacket",
    products: [
        .library(name: "XTerraPacket", targets: ["XTerraPacket"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Xenoxiluna/SwiftyBytes.git", .upToNextMinor(from:"0.2.0")),
    ],
    targets: [
        .target(name: "XTerraPacket", dependencies: ["SwiftyBytes"]),
        .testTarget(name: "XTerraPacketTests", dependencies: ["XTerraPacket"]),
    ]
)
