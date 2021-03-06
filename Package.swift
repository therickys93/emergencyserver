import PackageDescription

let package = Package(
    name: "emergencyserver",
    targets: [
    	Target(name: "App", dependencies: ["Library"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
        .Package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver-Vapor.git", majorVersion: 1),
    ]
)
