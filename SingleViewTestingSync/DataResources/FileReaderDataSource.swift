//
//  FileManager.swift
//  SingleViewTesting
//
//  Created by Jarle Heldstab on 23/12/2017.
//  Copyright © 2017 Jarle Heldstab. All rights reserved.
//
//  Struct for reading data from common file, responislbe for making csv file sensible

import Cocoa
import Foundation

class FileReaderDataSource
{
    // MARK: Static data variables
    static let sharedInstance = FileReaderDataSource()
    
    private let fileType = "csv"
    private(set) var fileData = [String]()
    
    private init()
    {
        // externalData = readContentOf(fileName: "oversikt" fileType: "csv")
        // interpretContentOf(externalData)
    }
    
    public func readCommaSeperatedContent(in file: String) -> [String]! {
        // guard lets you use filepath outside statement because it is unwrapped here, if let:
        // if let filePath != "", doesnt make sure it is not nil
        guard let filepath = Bundle.main.path(forResource: file, ofType: self.fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = contents.trimmingCharacters(in: .whitespacesAndNewlines)
            contents = contents.replacingOccurrences(of: "NULL", with: "")
            contents = contents.replacingOccurrences(of: "\r", with: "\n")
            contents = contents.replacingOccurrences(of: "\n\n", with: "\n")
            
            let rows = contents.components(separatedBy: "\n")

            return rows
        }
        catch {
            print("readCommaSeperatedContent error for file \(filepath)")
            return nil
        }
    }
    
    public func removeCommaSeperatedContent(in rows: [String], where columns: [String], doesNotContain: String) -> [String] {

        var filteredCommaSeperatedContent = [String]()
        
        if rows.count > 0 {
            for row in rows {
                // let columnValues = row.components(separatedBy: ";")
                
                if (row.lowercased().range(of: doesNotContain) != nil) {
                    //if (properties[3].caseInsensitiveCompare(lookFor) == ComparisonResult.orderedSame) {
                    //if (properties[3].lowercased().range(of: lookFor) != nil) {
                    //    correspondingItems.append(string)
                    //    print("Found \(lookFor), \(properties[1]) \(properties[2])")
                    //}
                    filteredCommaSeperatedContent.append(row)
                }
            }
        }
        return filteredCommaSeperatedContent
    }
}
