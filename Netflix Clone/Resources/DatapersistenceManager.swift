//
//  DatapersistenceManager.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 16/03/2022.
//

import Foundation
import UIKit
import CoreData

class DatapersistenceManager{
    static let shared = DatapersistenceManager()
    
    func downloadItemWith(model : Item, completion: @escaping () -> Void ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let request :NSFetchRequest<MediaItem>
        let context = appDelegate.persistentContainer.viewContext
        request = MediaItem.fetchRequest()
        do{
            let items = try context.fetch(request)
            for item in items{
                if item.id == Int64(model.id){
                    return
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        let item = MediaItem(context: context)
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.media_type = model.media_type
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count ?? 0)
        item.vote_average = model.vote_average
         
        do{
            try context.save()
            completion()
        } catch{
            print(error.localizedDescription)
        }
        
        
    }
    func fetchingItemsFromDatabase(completion : @escaping ([MediaItem]) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request :NSFetchRequest<MediaItem>
        request = MediaItem.fetchRequest()
        do{
            let items = try context.fetch(request)
            completion(items)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func deleteItemWith(model: MediaItem, completion : @escaping () -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do{
            try context.save()
            completion()
        }catch{
            print(error.localizedDescription)
        }
    }
}
