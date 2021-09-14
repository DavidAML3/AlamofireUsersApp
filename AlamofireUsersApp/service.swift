//
//  service.swift
//  AlamofireUsersApp
//
//  Created by David Andres Mejia Lopez on 14/09/21.
//

import Foundation
import Alamofire

class Service {
    
    fileprivate var baseUrl = ""
    typealias usersCallBack = (_ users: [User]?, _ status: Bool, _ message: String) -> Void
    var callBack: usersCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    // MARK: - getAllUsersNameFrom
    func getAllUsersNameFrom(endPoint: String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self.callBack?(users, true, "")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping usersCallBack) {
        self.callBack = callBack
    }
}
