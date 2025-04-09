//
//  moyaProvider.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Foundation
import Moya


let moyaProvider = NetworkClient(transport: MoyaProvider<MoyaAPI>(plugins: [NetworkLoggerPlugin()]))
