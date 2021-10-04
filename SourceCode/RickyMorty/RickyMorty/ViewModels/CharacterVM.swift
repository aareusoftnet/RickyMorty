//
//  CharacterVM.swift
//  RickyMorty
//

import Foundation

/**
 CharacterDetailVM class to manage character detail APIs call.
 ### Properties
 - **isLoaded**: Identify the character details is loaded or not.
 - **urlEndPoint**: Character details loading end point.
 - **details**: Details of the character.
 */
class CharacterDetailVM: NSObject {
    var isLoaded: Bool
    var urlEndPoint: URL
    var details: CharacterVM?
    
    init?(_ isLoaded: Bool = false, urlEndPoint: String) {
        guard let urlEndPoint = URL(string: urlEndPoint) else {return nil}
        self.isLoaded = isLoaded
        self.urlEndPoint = urlEndPoint
    }
    
    func update(_ details: CharacterVM) {
        self.isLoaded = true
        self.details = details
    }
}

/**
 CharacterVM struct used to display it's value on UIs part.
 ### Properties
 - **id**: The id of the character.
 - **image**: Image of the character.
 - **species**: The species of the character.
 - **status**: **CharacterStatusType** object to identify the status of the character.
 - **name**: The name of the character.
 - **type**: The type of the character.
 - **gender**: **CharacterGenderType** object to identify the gender of the character.
 - **origin**: Origin location of the character.
 - **lastLocation**: Last location of the character.

 */
struct CharacterVM {
    var id: Int
    var image: String
    var species: String
    var status: CharacterStatusType
    var name: String
    var type: String
    var gender: CharacterGenderType
    var origin: String
    var lastLocation: String
    var imageURL: URL? {
        return URL(string: image)
    }
    var displayType: String {
        return type.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "--" : type
    }

    /// It will initialized object from **Character** model
    /// - Parameter giphy: It will represent **Character** object value.
    init(_ character: Character) {
        id = character.id
        image = character.image
        species = character.species
        status = CharacterStatusType(rawValue: character.status)!
        name = character.name
        type = character.type
        gender = CharacterGenderType(rawValue: character.gender)!
        origin = character.origin.name
        lastLocation = character.location.name
    }
}
