//
//  ProjectItem+CoreDataProperties.swift
//  cashfocus
//
//  Created by Leon Walras Moura da Silva  on 2023-10-22.
//
//

import Foundation
import CoreData


extension ProjectItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectItem> {
        return NSFetchRequest<ProjectItem>(entityName: "ProjectItem")
    }

    @NSManaged public var projectName: String?
    @NSManaged public var projectDescription: String?
    @NSManaged public var projectTime: String?
    @NSManaged public var projectHourlyRate: Float
    @NSManaged public var createdAt: Date?

}

extension ProjectItem : Identifiable {

}
