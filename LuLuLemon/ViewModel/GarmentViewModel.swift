//
//  GarmentViewModel.swift
//  LuLuLemon
//
//  Created by Preeti Priyam on 7/20/21.
//

import Foundation
import CoreData
import UIKit

struct GarmentViewModel {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var garments : [Garment] = []
    
    init() {
        self.fetchGarements()
    }
    
    //function to fetch garment from coreData
    mutating func fetchGarements() {
        let request = NSFetchRequest<Garment>(entityName: Constants.entityName)
        let sort: NSSortDescriptor = NSSortDescriptor(key: Constants.name, ascending:true)
        request.sortDescriptors = [sort]
        do {
            garments = try context.fetch(request)
        } catch {
            print("error fetching data from the context\(error)")
        }
    }
    
    //function to save garments to core data
    mutating func saveData() {
        do {
            try context.save()
            print("data saved")
        } catch {
            print("Failed saving")
        }
    }
    
    //get total number of garments
    func getNumberOfGarments() -> Int{
        return garments.count
    }
    
    func garmentAtIndex(index: Int) -> Garment?{
        if(index < garments.count){
            return garments[index]
        }
        return nil
    }
    
    //function to call sort method
    mutating func requestSort(by condition: String){
        garments = sortGarment(object: garments, sortBy: condition)
    }
    
    //function to add garments to coredata
    mutating func addGarment(name: String){
        fetchGarements()
        let garment = Garment(context: context)
        garment.garmentName = name
        garment.identifier = Int16(garments.count)
        garment.createdOn = Date()
        self.garments.append(garment)
        requestSort(by: Constants.name)
        saveData()
    }
    
    //function to sort data
    func sortGarment(object: [Garment], sortBy: String) -> [Garment]{
        var garment = object
        for i in 0..<garment.count{
            for j in i..<garment.count{
                if(isGreater(g1: garment[i].value(forKey: sortBy), g2: garment[j].value(forKey: sortBy))){
                    let temp = garment[i]
                    garment[i] = garment[j]
                    garment[j] = temp
                }
            }
        }
        return garment
    }
    
    func isGreater<T>(g1: T, g2: T)  -> Bool{
        if let g1 = g1 as? String ,let g2 = g2 as? String{
            return g1 > g2
        }
        if let g1 = g1 as? Date ,let g2 = g2 as? Date{
            return g1 > g2
        }
        if let g1 = g1 as? Int16 ,let g2 = g2 as? Int16{
            return g1 > g2
        }
        return false
    }
}
