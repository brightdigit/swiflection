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

var classesDictionary = [String:Void](minimumCapacity: numberOfClasses)
while classesDictionary.count < classesDictionary.capacity {
  let numberOfProtocols = randomNumber(inTheRangeOf: rangeOfProtocolsPerClass)
  var protocols = [Character:Void](minimumCapacity: numberOfProtocols)
  while protocols.count < protocols.capacity {
    protocols[alphabet.randomItem] = ()
  }
  let key = Array(protocols.keys).map{String($0)}.joined(separator: "")
  classesDictionary[key] = ()
}
let classes = classesDictionary.keys

let protocols = classes.reduce([Character:[String]]()) { (dictionary, characters) -> [Character:[String]] in
  var dictionary = dictionary
  characters.forEach{
    var classes = dictionary[$0] ?? [String]()
    classes.append(characters)
    dictionary[$0] = classes
  }
  return dictionary
}

print("import Foundation")
print(protocols.map{ "@objc public protocol Protocol\($0.key){}"}.joined(separator: "\n"))
print(classes.map{ "public class Class\($0.map(String.init).joined(separator: "")): \($0.map{"Protocol\($0)"}.joined(separator: ", ")) {}"}.joined(separator: "\n"))

print(protocols.map{ "\($0.key): \($0.value.joined(separator: " "))" }.joined(separator: "\n"))

