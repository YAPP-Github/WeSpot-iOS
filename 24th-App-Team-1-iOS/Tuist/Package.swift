// swift-tools-version: 5.9
import PackageDescription


#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "Lottie"  : .framework,
            "Kingfisher": .framework,
            "KakaoSDKAuth": .framework,
            "KakaoSDKUser": .framework,
            "RxKakaoSDKAuth": .framework,
            "RxKakaoSDKUser": .framework
        ],
        baseSettings: .settings(configurations: [
            .debug(name: .configuration("DEV")),
            .release(name: .configuration("PRD"))
        ])
    )
#endif

let package = Package(
    name: "App",
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", from: "2.9.1"),
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.7.1"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources", from: "5.0.2"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/ReactorKit/ReactorKit", from: "3.2.0"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "2.22.5"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk-rx", branch: "2.22.5"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.24.0"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0")
    ]
)
