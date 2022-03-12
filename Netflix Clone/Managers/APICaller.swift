//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 11/03/2022.
//

import Foundation

struct Constants {
    static let API_KEY = "c6c5c638c61a623dc638ae62305c5b3d"
    static let baseURL = "https://api.themoviedb.org"
    
}
class APICaller {
    static let shared =  APICaller()
    
    func getTrendingMovies(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MoviesResponse.self, from: safeData)
                completion(results.results)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MoviesResponse.self, from: safeData)
                completion(results.results)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getUpcommingMovies(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MoviesResponse.self, from: safeData)
                completion(results.results)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getPopular(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MoviesResponse.self, from: safeData)
                completion(results.results)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func getTopRated(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(MoviesResponse.self, from: safeData)
                completion(results.results)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    
}
