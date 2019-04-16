// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sgit",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Quick/Quick", "2.0.0"..<"10.0.0"),
        .package(url: "https://github.com/Quick/Nimble", "8.0.0"..<"10.0.0"),
        .package(path: "./Modules/ShellCommand"),
        .package(url: "https://github.com/reactivex/rxswift", from: "4.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "sgit",
            dependencies: ["ShellCommand"]),
        .testTarget(
            name: "sgitTests",
            dependencies: ["sgit", "ShellCommand", "Quick", "Nimble"]),
    ]
)
