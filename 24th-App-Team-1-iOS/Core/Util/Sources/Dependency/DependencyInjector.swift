//
//  DependencyInjector.swift
//  Util
//
//  Created by Kim dohyun on 7/24/24.
//

import Foundation

import Swinject

public protocol DependencyAssemblable {
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
}

public protocol DependencyResolvable {
    func resolve<T>(_ serviceType: T.Type) -> T
    func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T
    func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T
    func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T
}

public typealias Injector = DependencyAssemblable & DependencyResolvable


public final class DependencyInjector: Injector {
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func assemble(_ assemblyList: [Assembly]) {
        assemblyList.forEach {
            $0.assemble(container: container)
        }
    }
    
    public func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object }
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
    
    public func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T {
        container.resolve(serviceType, argument: argument)!
    }
    
    public func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        return container.resolve(serviceType, arguments: arg1, arg2)!
    }
    
    public func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
        return container.resolve(serviceType, arguments: arg1, arg2, arg3)!
    }
    
}
