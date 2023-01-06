//
//  ResultPoint+CoreDataClass.swift
//  ArcheryPoints
//
//  Created by Evgenii Kutasov on 05.01.2023.
//
//

import Foundation
import CoreData

@objc(ResultPoint)
public class ResultPoint: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instatnce.entityForName(entityName: "ResultPoint"), insertInto: CoreDataManager.instatnce.context)
    }
    
}
