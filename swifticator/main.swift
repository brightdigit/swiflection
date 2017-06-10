//
//  main.swift
//  swifticator
//
//  Created by Leo Dion on 6/9/17.
//

import Foundation
import Darwin

func randomNumber(inTheRangeOf range: CountableClosedRange<Int>) -> Int {
  return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
}

extension Collection {
  var randomItem : Element {
    let offset = Int(arc4random_uniform(UInt32(self.count))) as! Self.IndexDistance
    let index = self.index(self.startIndex, offsetBy: offset)
    return self[index]
  }
}

var prtcls = [String]()
let alphabet = "01234567890ABCDEFGHJKMNPQRTUVWXYZ"

let rangeOfProtocolsPerClass = 0...5
let rangeOfNumberOfClasses = 20...40
//let numberOfClasses = arc4random_uniform(UInt32(rangeOfNumberOfClasses.upperBound - rangeOfNumberOfClasses.lowerBound)) + rangeOfNumberOfClasses.lowerBound

let numberOfClasses = randomNumber(inTheRangeOf: rangeOfNumberOfClasses)

let classes = (0..<numberOfClasses).map{_ -> [Character] in
  let numberOfProtocols = randomNumber(inTheRangeOf: rangeOfProtocolsPerClass)
  return (0..<numberOfProtocols).map{
    _ -> Character in
    return alphabet.characters.randomItem
  }
}

debugPrint(classes)
