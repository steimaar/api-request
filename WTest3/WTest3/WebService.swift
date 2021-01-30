//
//  WebService.swift
//  WTest3
//
//  Created by Sofia Marques Teixeira on 29/01/2021.
//

import Foundation


struct WebService {
    
    
    func requestAPI(_ link: String, completionHandler: @escaping([RicknMorty]) -> Void) {
           
            let url = URL(string: "https://rickandmortyapi.com/api/character")
            
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                
               if error == nil && data != nil {
                
                   //Json Parse
                
                let decoder = JSONDecoder()
                    
                    do {
                        let rickyResponseParsed = try decoder.decode(RicknMortyResponse.self, from: data!)
                        
                        let ricknMortyResults = rickyResponseParsed.results
                        
                        completionHandler(ricknMortyResults)
                        
                        
                        
                        print("Parsing was done")
                    }
                    
                    catch {
                        print("Error in parsing")
                    }
                }
            
             }
            
            task.resume()

            }
        
}
