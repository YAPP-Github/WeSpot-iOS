// swift-tools-version: 5.9
import PackageDescription
import ProjectDescriptionHelpers


#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "App",
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", exact: Version(stringLiteral: "2.9.1")),
        .package(id: "https://github.com/ReactiveX/RxSwift", exact: Version(stringLiteral: "6.7.1")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources", exact: Version(stringLiteral: "5.0.2")),
        .package(url: "https://github.com/SnapKit/SnapKit", exact: Version(stringLiteral: "5.7.1")),
    ]
)
