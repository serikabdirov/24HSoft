//
//  ApiClient.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
//

import Alamofire
import Foundation

final class ApiClient {
    static let shared = ApiClient(eventMonitors: [NetworkActivityLogger(level: .debug)])
    private let session: Session

    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "WbCbHyze4esA58Qdf8QM48t0Jc6hF46RIStoIDM9UoA"

    private init(
        configuration: URLSessionConfiguration = .af.default,
        interceptor: RequestInterceptor? = nil,
        eventMonitors: [EventMonitor] = []
    ) {
        self.session = Session(configuration: configuration, interceptor: interceptor, eventMonitors: eventMonitors)
    }

    func fetch() async throws -> [Photo] {
        let url = "\(baseURL)/photos/random"
        let parameters: Parameters = ["client_id": accessKey, "count": 30]

        return try await session.request(url, parameters: parameters)
            .validate()
            .serializingDecodable([Photo].self)
            .value
    }
}
