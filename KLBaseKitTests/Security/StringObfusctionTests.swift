//
//  StringObfusctionTests.swift
//  KSecKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class StringObfusctionTests: XCTestCase {

    func testLetters() {
        XCTAssertEqual(String().a, "a")
        XCTAssertEqual(String().b, "b")
        XCTAssertEqual(String().c, "c")
        XCTAssertEqual(String().d, "d")
        XCTAssertEqual(String().e, "e")
        XCTAssertEqual(String().f, "f")
        XCTAssertEqual(String().g, "g")
        XCTAssertEqual(String().h, "h")
        XCTAssertEqual(String().i, "i")
        XCTAssertEqual(String().j, "j")
        XCTAssertEqual(String().k, "k")
        XCTAssertEqual(String().l, "l")
        XCTAssertEqual(String().m, "m")
        XCTAssertEqual(String().n, "n")
        XCTAssertEqual(String().o, "o")
        XCTAssertEqual(String().p, "p")
        XCTAssertEqual(String().q, "q")
        XCTAssertEqual(String().r, "r")
        XCTAssertEqual(String().s, "s")
        XCTAssertEqual(String().t, "t")
        XCTAssertEqual(String().u, "u")
        XCTAssertEqual(String().v, "v")
        XCTAssertEqual(String().w, "w")
        XCTAssertEqual(String().x, "x")
        XCTAssertEqual(String().y, "y")
        XCTAssertEqual(String().z, "z")
        XCTAssertEqual(String().ä, "ä")
        XCTAssertEqual(String().ö, "ö")
        XCTAssertEqual(String().ü, "ü")
        XCTAssertEqual(String().ß, "ß")
    }

    func testCaptialLetters() {
        XCTAssertEqual(String().A, "A")
        XCTAssertEqual(String().B, "B")
        XCTAssertEqual(String().C, "C")
        XCTAssertEqual(String().D, "D")
        XCTAssertEqual(String().E, "E")
        XCTAssertEqual(String().F, "F")
        XCTAssertEqual(String().G, "G")
        XCTAssertEqual(String().H, "H")
        XCTAssertEqual(String().I, "I")
        XCTAssertEqual(String().J, "J")
        XCTAssertEqual(String().K, "K")
        XCTAssertEqual(String().L, "L")
        XCTAssertEqual(String().M, "M")
        XCTAssertEqual(String().N, "N")
        XCTAssertEqual(String().O, "O")
        XCTAssertEqual(String().P, "P")
        XCTAssertEqual(String().Q, "Q")
        XCTAssertEqual(String().R, "R")
        XCTAssertEqual(String().S, "S")
        XCTAssertEqual(String().T, "T")
        XCTAssertEqual(String().U, "U")
        XCTAssertEqual(String().V, "V")
        XCTAssertEqual(String().W, "W")
        XCTAssertEqual(String().X, "X")
        XCTAssertEqual(String().Y, "Y")
        XCTAssertEqual(String().Z, "Z")
        XCTAssertEqual(String().Ä, "Ä")
        XCTAssertEqual(String().Ö, "Ö")
        XCTAssertEqual(String().Ü, "Ü")
    }

    func testNumbers() {
        XCTAssertEqual(String()._0, "0")
        XCTAssertEqual(String()._1, "1")
        XCTAssertEqual(String()._2, "2")
        XCTAssertEqual(String()._3, "3")
        XCTAssertEqual(String()._4, "4")
        XCTAssertEqual(String()._5, "5")
        XCTAssertEqual(String()._6, "6")
        XCTAssertEqual(String()._7, "7")
        XCTAssertEqual(String()._8, "8")
        XCTAssertEqual(String()._9, "9")
    }

    func testSpecial() {
        XCTAssertEqual(String().dash, "-")
        XCTAssertEqual(String().underscore, "_")
        XCTAssertEqual(String().colon, ":")
        XCTAssertEqual(String().space, " ")
        XCTAssertEqual(String().dot, ".")
        XCTAssertEqual(String().comma, ",")
        XCTAssertEqual(String().semicolon, ";")
        XCTAssertEqual(String().quotation, "\"")
        XCTAssertEqual(String().plus, "+")
        XCTAssertEqual(String().minus, "-")
        XCTAssertEqual(String().equals, "=")
        XCTAssertEqual(String().asterisk, "*")
        XCTAssertEqual(String().ampersand, "&")
        XCTAssertEqual(String().at, "@")
        XCTAssertEqual(String().dollar, "$")
        XCTAssertEqual(String().pound, "#")
        XCTAssertEqual(String().euro, "€")
        XCTAssertEqual(String().percent, "%")
        XCTAssertEqual(String().apostrophe, "'")
        XCTAssertEqual(String().question_mark, "?")
        XCTAssertEqual(String().backSlash, "\\")
        XCTAssertEqual(String().forwardSlash, "/")
        XCTAssertEqual(String().curlyLeft, "{")
        XCTAssertEqual(String().curlyRight, "}")
        XCTAssertEqual(String().bracketLeft, "[")
        XCTAssertEqual(String().bracketRight, "]")
        XCTAssertEqual(String().bar, "|")
        XCTAssertEqual(String().lessThan, "<")
        XCTAssertEqual(String().greaterThan, ">")
        XCTAssertEqual(String().exclamation, "!")
        XCTAssertEqual(String().caret, "^")
        XCTAssertEqual(String().parenLeft, "(")
        XCTAssertEqual(String().parenRight, ")")
    }

}
