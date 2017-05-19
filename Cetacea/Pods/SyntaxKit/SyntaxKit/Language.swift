//
//  Language.swift
//  SyntaxKit
//
//  Represents a textmate syntax file (.tmLanguage). Before use the
//  validate method has to be called on it.
//
//  Created by Sam Soffes on 9/18/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//

public struct Language {

    // MARK: - Properties

    public let uuid: UUID
    public let name: String
    public let scopeName: String

    let pattern: Pattern = Pattern()
    let referenceManager: ReferenceManager
    let repository: Repository

    static let globalScope = "GLOBAL"

    // MARK: - Initializers

    init?(dictionary: [String: Any], manager: BundleManager) {
        guard let uuidString = dictionary["uuid"] as? String,
            let uuid = UUID(uuidString: uuidString),
            let name = dictionary["name"] as? String,
            let scopeName = dictionary["scopeName"] as? String,
            let array = dictionary["patterns"] as? [[String: Any]]
            else { return nil }

        self.uuid = uuid
        self.name = name
        self.scopeName = scopeName
        self.referenceManager = ReferenceManager(bundleManager: manager)

        self.pattern.subpatterns = referenceManager.patterns(for: array, in: nil, caller: nil)
        self.repository = Repository(repo: dictionary["repository"] as? [String: [AnyHashable: Any]] ?? [:], inParent: nil, with: referenceManager)
        referenceManager.resolveInternalReferences(with: repository, in: self)
    }

    /// Resolves all external reference the language has to the given languages.
    /// Only after a call to this method the Language is fit for general use.
    ///
    /// - parameter helperLanguages: The languages that the language has
    ///     references to resolve against. This should at least contain the
    ///     language itself.
    mutating func validate(with helperLanguages: [Language]) {
        ReferenceManager.resolveExternalReferences(between: helperLanguages, basename: self.scopeName)
    }
}
