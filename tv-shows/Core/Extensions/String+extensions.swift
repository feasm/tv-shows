//
//  String+extensions.swift
//  tv-shows
//
//  Created by Felipe Melo on 04/07/22.
//

import Foundation

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!,
                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil).string
    }
}
