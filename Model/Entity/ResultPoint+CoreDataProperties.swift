//
//  ResultPoint+CoreDataProperties.swift
//  ArcheryPoints
//
//  Created by Evgenii Kutasov on 05.01.2023.
//
//

import Foundation
import CoreData


extension ResultPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultPoint> {
        return NSFetchRequest<ResultPoint>(entityName: "ResultPoint")
    }

    @NSManaged public var countSet: Int16
    @NSManaged public var numberSet: Int16

}

extension ResultPoint : Identifiable {

}
