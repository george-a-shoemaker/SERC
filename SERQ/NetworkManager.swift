//
//  NetworkManager.swift
//  SERQ
//
//  Created by George Shoemaker on 4/20/23.
//

import Foundation

fileprivate let localHost = URL(string: "http://localhost:8000/")!

class NetworkManager {
    static let shared = NetworkManager(
        baseUrl: localHost
    )
    
    private init(baseUrl: URL) {
        self.baseUrl = localHost
        self.waitlistMenUrl = baseUrl.appendingPathComponent("waitlist/men")
        self.waitlistMenSearchUrl = waitlistMenUrl.appendingPathComponent("search")
    }
    
    let baseUrl: URL
    let waitlistMenUrl: URL
    let waitlistMenSearchUrl: URL
    
    func getWaitlistMen() async throws -> Data {
        var request = URLRequest(url: waitlistMenUrl)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func getWaitlistMenSearch(lastName: String, firstNameInitial: String) async throws -> Data {
        var urlComponents = URLComponents(
            url: waitlistMenSearchUrl,
            resolvingAgainstBaseURL: true
        )!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lastName", value: lastName),
            URLQueryItem(name: "firstNameInitial", value: firstNameInitial)
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
