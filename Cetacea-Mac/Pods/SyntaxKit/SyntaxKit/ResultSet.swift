//
//  ResultSet.swift
//  SyntaxKit
//
//  Stores a set of results generated by the parser.
//
//  Created by Sam Soffes on 10/11/14.
//  Copyright © 2014-2015 Sam Soffes. All rights reserved.
//

class ResultSet {

    // MARK: - Properties

    var results: [Result] { return _results }
    /// Guaranteed to be larger or equal to the union of all the ranges
    /// associated with the contained results.
    var range: NSRange { return _range }

    fileprivate var _results = [Result]()
    fileprivate var _range: NSRange

    // MARK: - Initializers

    init(startingRange range: NSRange) {
        _range = range
    }

    // MARK: - Adding

    func extend(with range: NSRange) {
        _range = NSUnionRange(self.range, range)
    }

    func add(_ result: Result) {
        extend(with: result.range)
        _results.append(result)
    }

    func add(_ resultSet: ResultSet) {
        extend(with: resultSet.range)
        for result in resultSet.results {
            _results.append(result)
        }
    }
}
