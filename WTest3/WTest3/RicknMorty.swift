//
//  Pokemon.swift
//  WTest3
//
//  Created by Sofia Marques Teixeira on 29/01/2021.
//

import Foundation


struct RicknMortyResponse: Decodable {
    var results:[RicknMorty]
}


struct RicknMorty: Decodable {
    var name:String
    var image:String
}
