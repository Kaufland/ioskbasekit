//
//  SecurityStatus+Debugger.swift
//  KSecKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension SecurityStatus {
    public struct Debugger {
        public static var connected: Bool {
            return ttyWayConnected || defaultWayConnected
        }

        public static var ttyWayConnected: Bool {
            let fd = STDERR_FILENO
            if fcntl(fd, F_GETFD, 0) < 0 {
                return false
            }

            var buf = [CChar](repeating: 0, count: Int(MAXPATHLEN))

            if fcntl(fd, F_GETPATH, &buf) >= 0 {
                if strncmp(&buf, "/dev/null", 9) == 0 {
                    return false
                }
                if strncmp(&buf, "/dev/tty", 8) == 0 {
                    return true
                }
            }

            return false
        }

        public static var defaultWayConnected: Bool {
            var info = kinfo_proc()
            var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
            var size = MemoryLayout<kinfo_proc>.stride
            sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
            return (info.kp_proc.p_flag & P_TRACED) != 0
        }

    }
}
