
import Foundation
import UIKit
extension Array {
    func indexOfObject<T: Equatable>(_ array: Array<T>, object: T) -> Int? {
        for i in 0..<array.count {
            if (array[i] == object) {
                return i
            }
        }
        return nil
    }
    
}
extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
    func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.uniqInPlace()
        return arrayCopy
    }
    func containsCount<T>(_ obj: T) -> Int where T : Equatable {
        return self.filter({$0 as? T == obj}).count
    }
    mutating func uniqInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index+=1
            }
        }
    }
}
extension Sequence where Self.Iterator.Element: Hashable {
    func freq() -> [Self.Iterator.Element: Int] {
        return reduce([:]) { (accu: [Self.Iterator.Element: Int], element) in
            var accu = accu
            
            //FIXME: secusser
            accu[element] = accu[element] ?? 1
            return accu
        }
    }
}
extension Sequence where Self.Iterator.Element: Equatable {
    func freqTuple() -> [(Self.Iterator.Element, Int)] {
        
        let empty: [(Self.Iterator.Element, Int)] = []
        
        return reduce(empty) { (accu: [(Self.Iterator.Element, Int)], element) in
            var accu = accu
            for (index, value) in accu.enumerated() {
                if value.0 == element {
                    accu[index].1 += 1
                    return accu
                }
            }
            
            return accu + [(element, 1)]
        }
    }
}


extension NSMutableIndexSet {
    func toArray() -> [Int] {
        var indexes:[Int] = [];
        self.enumerate { (index:Int, _) in
            indexes.append(index);
        }
        return indexes;
    }
}


