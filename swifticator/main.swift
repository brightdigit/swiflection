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

let minimumProtocolsPerClass = 1
let maximumProtocolsPerClass = 5
let rangeOfProtocolsPerClass = minimumProtocolsPerClass...maximumProtocolsPerClass

let minimumNumberOfClasses = 20
let maximumNumberOfClasses = 40
let rangeOfNumberOfClasses = minimumNumberOfClasses...maximumNumberOfClasses

let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)

let swiftCodeFileURL = URL(fileURLWithPath: CommandLine.arguments[1], relativeTo: currentDirectoryURL)

let protocolListURL = URL(fileURLWithPath: CommandLine.arguments[2], relativeTo: currentDirectoryURL)

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


var code = ["import Foundation"]
code.append(protocols.map{ "@objc public protocol Protocol\($0.key){}"}.joined(separator: "\n"))
code.append(classes.map{ "public class Class\($0.map(String.init).joined(separator: "")): \($0.map{"Protocol\($0)"}.joined(separator: ", ")) {}"}.joined(separator: "\n"))

let list = protocols.map{ "\($0.key): \($0.value.joined(separator: " "))" }.joined(separator: "\n")

try! code.joined(separator: "\n").write(to: swiftCodeFileURL, atomically: true, encoding: .utf8)
print("wrote code to \(swiftCodeFileURL).")
try! list.write(to: protocolListURL, atomically: true, encoding: .utf8)
print("wrote protoocols to \(protocolListURL).")
