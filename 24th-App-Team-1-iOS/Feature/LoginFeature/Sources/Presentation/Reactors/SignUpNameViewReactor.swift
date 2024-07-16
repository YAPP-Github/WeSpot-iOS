//
//  SignUpNameViewReactor.swift
//  LoginFeature
//
//  Created by eunseou on 7/12/24.
//

import Foundation

import ReactorKit

public final class SignUpNameViewReactor: Reactor {
    
    public struct State {
        var name: String = ""
        var errorMessage: String?
        var isButtonEnabled: Bool = false
        var isWarningHidden: Bool = true
    }
    
    public enum Action {
        case inputName(String)
        case nextButtonTap
    }
    
    public enum Mutation {
        case setName(String)
        case setErrorMessage(String?)
        case setButtonEnabled(Bool)
        case setWarningHidden(Bool)
    }
    
    public var initialState: State
    
    public init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputName(let name):
            let isValid = self.validateName(name)
            let errorMessage = isValid ? nil : (name.count <= 1 ? nil : "2~5자의 한글만 입력 가능해요")
            let isButtonEnabled = name.count >= 2 && isValid
            let isWarningHidden = name.count <= 1
            
            return Observable.concat([
                .just(Mutation.setName(name)),
                .just(Mutation.setErrorMessage(errorMessage)),
                .just(Mutation.setButtonEnabled(isButtonEnabled)),
                .just(Mutation.setWarningHidden(isWarningHidden))
            ])
            
        case .nextButtonTap:
            return .just(.setButtonEnabled(true))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setName(let name):
            newState.name = name
            
        case .setErrorMessage(let errorMessage):
            newState.errorMessage = errorMessage
            
        case .setButtonEnabled(let isEnabled):
            newState.isButtonEnabled = isEnabled
            
        case .setWarningHidden(let isHidden):
            newState.isWarningHidden = isHidden
        }
        
        return newState
    }
    
    private func validateName(_ name: String) -> Bool {
        let regex = "^[가-힣]{2,5}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
}
