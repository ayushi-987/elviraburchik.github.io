// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ElviraburchikGithubIo",
    products: [
        .executable(name: "ElviraburchikGithubIo", targets: ["ElviraburchikGithubIo"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "ElviraburchikGithubIo",
            dependencies: ["Publish"]
        )
    ]
)