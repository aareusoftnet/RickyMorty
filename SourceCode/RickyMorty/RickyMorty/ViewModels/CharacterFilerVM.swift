//
//  CharacterFilerVM.swift
//  RickyMorty
//

import UIKit

//MARK: - Struct CharacterFilter
struct CharacterFilter {
    var statusFilter: CharacterFilterVM!
    var genderFilter: CharacterFilterVM!
    
    init(_ statusFilter: CharacterFilterVM, genderFilter: CharacterFilterVM) {
        self.statusFilter = statusFilter
        self.genderFilter = genderFilter
    }
}

//MARK: - Struct CharacterFilterVM
struct CharacterFilterVM {
    var filterOption: CharacterFilterOption
    var isSelected: Bool
    var selectedOption: Any?
    var allOptions: [Any] {
        return filterOption.options
    }
    
    init(_ filterOption: CharacterFilterOption, isSelected: Bool, selectedOption: Any?) {
        self.filterOption = filterOption
        self.isSelected = isSelected
        self.selectedOption = selectedOption
    }
    
    mutating func set(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
}
