import Foundation

let zeroRange = 0...0

extension String {
  public init?(data: [Int8]) {
    if let string = String.fromCString(data + [0]) {
      self.init(string)
    } else {
      return nil
    }
  }

  public init?(data: [UInt8]) {
    var string = ""
    var decoder = UTF8()
    var generator = data.generate()
    var finished = false

    while !finished {
      let decodingResult = decoder.decode(&generator)
      switch decodingResult {
        case .Result(let char): string.append(char)
        case .EmptyInput: finished = true
        case .Error: return nil
      }
    }

    self.init(string)
  }
}

///use string with this way
///let helloWorld = "Hello, world!"
///var hello      = helloWorld[0...4]
///print(hello)
extension String {
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex   = self.startIndex.advancedBy(r.endIndex)

            return self[Range(start: startIndex, end: endIndex)]
        }
  }

  private func _find(subString: String) -> Int {
      var start = startIndex

      repeat {
          let other = self[Range(start: start, end: endIndex)]
          if other.hasPrefix(subString){
              return startIndex.distanceTo(start)
          }

          start++

      } while start != endIndex

      return -1
  }

  func find(subString: String, range:Range<Int> = zeroRange) -> Int {

      if range == zeroRange {
          return self._find(subString)
      } else {
          let rangeStr = self[range]

          return rangeStr._find(subString)
      }

  }

  func split(str: Character, numSplit: Int = 0) -> [String]  {

        if numSplit == 0 {
            let selfArr = self.characters.split{$0 == str}

            let strArray = selfArr.map { String($0) }
            return strArray
        } else {
            let selfArr = self.characters.split(numSplit) {$0 == str}

            let strArray = selfArr.map { String($0) }
            return strArray
        }


    }

    /**
        Gets the character at the specified index as String.
        If index is negative it is assumed to be relative to the end of the String.
        :param: index Position of the character to get
        :returns: Character as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
        if index < self.characters.count {
            return self[index...index]
        }

        return nil
    }


}
