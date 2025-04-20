// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct ChallengeResponse: Encodable {
    public let challenge: String
    public let clientData: String
    public let signatureData: String
    public let authenticatorData: String
    public let userHandle: String
    public let credentialID: String
    public let rpId: String
}
