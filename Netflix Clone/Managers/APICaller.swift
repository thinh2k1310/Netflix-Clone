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
    static let YoutubeAPI_KEY = "AIzaSyBoSRu6BADq1vaTZTkjrdmCaDy7ozd5eH8"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"

    
    
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
    func discoverMovies(completion : @escaping ([Item]) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc") else {return}
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
    func search(for query : String, completion : @escaping ([Item]) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)&page=1") else {return}
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
    
    func getYoutubeMovies(with query : String, completion : @escaping (VideoElement) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            guard let safeData = data, error == nil else{
                return
            }
            let decoder = JSONDecoder()
            do {
                //let result = try JSONSerialization.jsonObject(with: safeData, options: .fragmentsAllowed)
                let results = try decoder.decode(YoutubeSeachResults.self, from: safeData)
                completion(results.items[0])
            }
            catch{
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    
    
    
}
