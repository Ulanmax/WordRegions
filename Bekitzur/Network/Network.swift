

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class Network<T: Codable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    private let token = "9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee"
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItems(_ path: String) -> Observable<ResponseModel<[T]>> {
        let params = ["token": token]
        return self.getItem(path, responseType: [T].self, params: params)
    }

    func getItem<Type: Codable>(_ path: String, responseType: Type.Type, params: [String : Any] = [:]) -> Observable<ResponseModel<Type>> {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .data(.get, absolutePath, parameters: params, headers: headers)
            .debug()
            .observeOn(scheduler)
            .map({ data -> ResponseModel<Type> in
                return try JSONDecoder().decode(ResponseModel<Type>.self, from: data)
            })
    }

}

