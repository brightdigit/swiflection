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

let rangeOfProtocolsPerClass = 1...5
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

let protocols = classes.reduce([Character:[[Character]]]()) { (dictionary, characters) -> [Character:[[Character]]] in
  var dictionary = dictionary
  characters.forEach{
    var classes = dictionary[$0] ?? [[Character]]()
    classes.append(characters)
    dictionary[$0] = classes
  }
  return dictionary
}

print(protocols.map{ "@objc public protocol Protocol\($0.key){}"}.joined(separator: "\n"))
print(classes.map{ "public class Class\($0.map(String.init).joined(separator: "")): \($0.map{"Protocol\($0)"}.joined(separator: " ")) {}"}.joined(separator: "\n"))
//A: AB AC AG
//class ClassAB : ProtocolA, ProtocolB  {
//}
//
//@objc protocol ProtocolA {
//
//}

