//
//  PersistentController.swift
//  Halmooni
//
//  Created by 문인범 on 5/19/24.
//

import CoreData




// MARK: - Core Data
struct PersistentController {
    static let shared = PersistentController()
    
    let container: NSPersistentCloudKitContainer
    
    private init() {
        container = NSPersistentCloudKitContainer(name: "DiaryModel")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent store, \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}


extension PersistentController {
    func saveDiary(recordUrl: URL, image: Data, template: Int, token: Int, date: Date?) throws {
//        guard let cloudURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appending(path: "Documents") else {
//            throw CoreDataError.failedToGetURL
//        }
        
        
        let diary = Diary(context: container.viewContext)
        diary.id = UUID()
        diary.recordUrl = recordUrl.absoluteString
        diary.image = image
        diary.pickedTemplate = Int16(template)
        diary.savedDate = Date()
        
        if let date = date {
            diary.uploadDate = date
        }
        
        diary.tokenCount = Int16(token)
        diary.isRead = false
        
        do {
            try container.viewContext.save()
        } catch {
            fatalError("Failed to save context, \(error.localizedDescription)")
        }
    }
    
    func deleteDiary(diary: Diary) {
        do {
            container.viewContext.delete(diary)
            try container.viewContext.save()
        } catch {
            fatalError("Failed to delete diary, \(error.localizedDescription)")
        }
    }
}

extension PersistentController {
    public func saveLetter(id: UUID, date: Date, url: URL) {
        let letter = Letter(context: self.container.viewContext)
        let urlString = url.relativeString
        
        letter.id = id
        letter.savedDate = date
        letter.recordUrl = urlString
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Failed to save, \(error.localizedDescription)")
        }
    }
}

enum CoreDataError: Error {
    case failedToGetURL
}
