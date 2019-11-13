// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftHEIF",
    products: [
        .library(name: "SwiftHEIF", targets: ["SwiftHEIF"]),
    ],
    targets: [
        .systemLibrary(name: "SwiftHEIF"),
    ]
    
//    pkgConfig: "wtf",
//    providers: [
//    .brew(["libheif"])
////    .apt([""])
//    ],
//    dependencies: [
//        // Dependencies declare other packages that this package depends on.
//        // .package(url: /* package url */, from: "1.0.0"),
//    ]
)

//name: "Cgd",
//pkgConfig: "gdlib",
//providers: [
//.brew(["gd"]),
//.apt(["libgd-dev"])
//]
