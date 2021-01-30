//
//  CoreData.swift
//  WTest3
//
//  Created by Sofia Marques Teixeira on 29/01/2021.
//

import Foundation
import UIKit
import CoreData

struct CoreData {
    
    func createData(arr: [RicknMorty]){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "RickyModel", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        for object in arr {
            
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(object.name, forKey: "name")
            user.setValue(object.image, forKey: "image")
            
        }
        
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveData() -> [RicknMorty] {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RickyModel")
        
        var rickyList = [RicknMorty]()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            
            for data in result {
                
                let ricky = RicknMorty(name: data.value(forKey: "name") as! String, image: data.value(forKey: "image") as! String)
                
                rickyList.append(ricky)
            }

            
        } catch {
            
            print("Failed")
        }
        return rickyList
    }
    
}


