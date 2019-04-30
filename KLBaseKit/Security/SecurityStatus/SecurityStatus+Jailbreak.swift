//
//  SecurityStatus+Jailbreak.swift
//  KSecKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension SecurityStatus {
    struct Jailbreak {
        public static var isJailbrokenSimple: Bool {

            if FileManager.default.fileExists(atPath: String().forwardSlash.A.p.p.l.i.c.a.t.i.o.n.s.forwardSlash.C.y.d.i.a.dot.a.p.p) {
                return true
            } else if FileManager.default.fileExists(atPath: String().forwardSlash.L.i.b.r.a.r.y.forwardSlash
                .M.o.b.i.l.e.S.u.b.s.t.r.a.t.e.forwardSlash.M.o.b.i.l.e.S.u.b.s.t.r.a.t.e.dot.d.y.l.i.b) {
                return true
            } else if FileManager.default.fileExists(atPath: String().forwardSlash.b.i.n.forwardSlash.b.a.s.h) {
                return true
            } else if FileManager.default.fileExists(atPath: String().forwardSlash.u.s.r.forwardSlash.s.b.i.n.forwardSlash.s.s.h.d) {
                return true
            } else if FileManager.default.fileExists(atPath: String().forwardSlash.e.t.c.forwardSlash.a.p.t) {
                return true
            } else if FileManager.default.fileExists(atPath: String().forwardSlash.p.r.i.v.a.t.e.forwardSlash.v.a.r.forwardSlash.l.i.b.forwardSlash.a.p.t.forwardSlash) {
                return true
            }

            var file = fopen(String().forwardSlash.b.i.n.forwardSlash.b.a.s.h, "r")
            if let file = file {
                fclose(file)
                return true
            }
            fclose(file)

            file = fopen(String().forwardSlash.A.p.p.l.i.c.a.t.i.o.n.s.forwardSlash.C.y.d.i.a.dot.a.p.p, "r")
            if let file = file {
                fclose(file)
                return true
            }
            fclose(file)

            file = fopen(String().forwardSlash.L.i.b.r.a.r.y.forwardSlash
                .M.o.b.i.l.e.S.u.b.s.t.r.a.t.e.forwardSlash.M.o.b.i.l.e.S.u.b.s.t.r.a.t.e.dot.d.y.l.i.b, "r")
            if let file = file {
                fclose(file)
                return true
            }
            fclose(file)

            file = fopen(String().forwardSlash.u.s.r.forwardSlash.s.b.i.n.forwardSlash.s.s.h.d, "r")
            if let file = file {
                fclose(file)
                return true
            }
            fclose(file)

            file = fopen(String().forwardSlash.e.t.c.forwardSlash.a.p.t, "r")
            if let file = file {
                fclose(file)
                return true
            }
            fclose(file)

            let string = String().K.a.u.f.l.a.n.d
            let filename = String().forwardSlash.p.r.i.v.a.t.e.forwardSlash.t.e.s.t.dot.t.x.t
            var errorOccured = false
            do {
                try string.write(toFile: filename, atomically: true, encoding: .utf8)
            } catch {
                errorOccured = true
            }

            if !errorOccured {
                try? FileManager.default.removeItem(atPath: filename)
                return true
            }

            return false
        }
    }
}
