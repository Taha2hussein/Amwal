//
//  EnviromentConfigurations.swift
//  TeldaTask
//
//  Created by Taha Hussein on 28/11/2024.
//

import Foundation
enum EnviromentConfigurations: String {
    case baseUrl = "https://api.amwal.hazaber.com"
   case imageUrl = "https://image.tmdb.org/t/p/w500"
    var value : String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}

//https:developers.themoviedb.org/3/movies/get-popular-movies
//https:api.themoviedb.org/3/movie/popular
