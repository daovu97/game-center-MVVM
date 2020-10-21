//
//  Observable+Extension.swift
//  AutoLayoutEx2
//
//  Created by daovu on 9/8/20.
//  Copyright © 2020 daovu. All rights reserved.
//

import Foundation

//extension ObservableType {
//    
//    func ignoreAll() -> Observable<Void> {
//        return map { _ in }
//    }
//    
//    func unwrap<T>() -> Observable<T> where Element == T? {
//        return compactMap { $0 }
//    }
//
//    func execute(_ selector: @escaping (Element) -> Void) -> Observable<Element> {
//        return flatMap { result in
//             return Observable
//                .just(selector(result))
//                .map { _ in result }
//                .take(1)
//        }
//    }
//
//    func count() -> Observable<(Element, Int)> {
//        var numberOfTimesCalled = 0
//        let result = map { _ -> Int in
//            numberOfTimesCalled += 1
//            return numberOfTimesCalled
//        }
//
//        return Observable.combineLatest(self, result)
//    }
//
//    func merge(with other: Observable<Element>) -> Observable<Element> {
//        return Observable.merge(self.asObservable(), other)
//    }
//    
//    func orEmpty() -> Observable<Element> {
//        return catchError { _ in
//            return .empty()
//        }
//    }
//    
//    func map<T>(to value: T) -> Observable<T> {
//        return map { _ in value }
//    }
//    
//}
