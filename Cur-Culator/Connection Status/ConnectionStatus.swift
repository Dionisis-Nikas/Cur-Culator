//
//  ConnectionStatus.swift
//  Cur-Culator
//
//  Created by Dionisis Nikas on 23/3/22.
//

import Foundation
import SystemConfiguration

class ConnectionStatus: ObservableObject {
    @Published private(set) var reachable: Bool = false
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.designcode.io")

    init() {
        self.reachable = checkConnection()
    }

    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }

    func checkConnection() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        return isNetworkReachable(with: flags)
    }
}
