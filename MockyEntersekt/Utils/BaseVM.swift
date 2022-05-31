//
//  BaseVM.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Combine
import Foundation

protocol BaseViewModelling {
    var triggerAPI: PassthroughSubject<Void, Never> { get }
    var networkError: PassthroughSubject<Void, Never> { get }
    var unauthorizedError: PassthroughSubject<Void, Never> { get }
    var apiError: PassthroughSubject<String, Never> { get }
    var successResponse: PassthroughSubject<MockyResponse, Never> { get }
}

class BaseViewModel {
    var triggerAPI = PassthroughSubject<Void, Never>()
   // var sessionText = CurrentValueSubject<String, Never>("")
    let networkError = PassthroughSubject<Void, Never>()
    let unauthorizedError = PassthroughSubject<Void, Never>()
    let apiError = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    var successResponse = PassthroughSubject<MockyResponse, Never>()
}

