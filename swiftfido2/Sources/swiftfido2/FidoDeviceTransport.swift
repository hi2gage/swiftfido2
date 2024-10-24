//
//  File.swift
//  swiftfido2
//
//  Created by Gage Halverson on 10/23/24.
//

import Foundation

// Define Swift function types for rx and tx (similar to fido_dev_rx_t and fido_dev_tx_t)
typealias FidoDevRx = (Data) -> Data?
typealias FidoDevTx = (Data) -> Bool
// Define the FidoDeviceTransport struct
struct FidoDeviceTransport {
    var rx: FidoDevRx?  // Optional, as in C they could be NULL
    var tx: FidoDevTx?

    init(rx: FidoDevRx? = nil, tx: FidoDevTx? = nil) {
        self.rx = rx
        self.tx = tx
    }
}
