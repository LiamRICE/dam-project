//
//  SortObject.swift
//  dam-project
//
//  Created by m1 on 02/03/2022.
//

import Foundation

public class TechnicalDocumentListSearch: Equatable{
    private var regex: String
    private var id: Int
    private var category: String
    
    init(){
        self.regex = ""
        self.id = -1
        self.category = ""
    }
    
    public func setCategory(cat: String){
        self.category = cat
    }
    
    public func setSearch(search: String){
        if let num = Int(search){
            self.id = num
            self.regex = ""
        } else {
            self.regex = search
            self.id = -1
        }
    }
    
    public func searchTechnicalDocuments(techdoc: [TechnicalDocument]) -> [TechnicalDocument]{
        if self.id == -1 && self.regex == ""{
            return sortByCategory(techdoc: techdoc)
        } else if self.id != -1 {
            return sortById(techdoc: techdoc)
        } else {
            return sortByRegex(techdoc: techdoc)
        }
    }
    
    private func sortByCategory(techdoc: [TechnicalDocument]) -> [TechnicalDocument]{
        let result = techdoc.filter({ i in
            print("\(i.name) : \(i.category) == \(self.category) => \(i.category == self.category)")
            return i.category == self.category || self.category == "Tous"
        })
        return result
    }
    
    private func sortById(techdoc: [TechnicalDocument]) -> [TechnicalDocument]{
        var result = sortByCategory(techdoc: techdoc)
        result = result.filter({ i in
            return i.id == self.id
        })
        return result
    }
    
    private func sortByRegex(techdoc: [TechnicalDocument]) -> [TechnicalDocument]{
        var result = sortByCategory(techdoc: techdoc)
        result = result.filter({ i in
            return i.name.lowercased().contains(self.regex.lowercased())
        })
        return result
    }
    
    public static func == (lhs: TechnicalDocumentListSearch, rhs: TechnicalDocumentListSearch) -> Bool {
        return lhs.id == rhs.id && lhs.regex == rhs.regex && lhs.category == rhs.category
    }
}
