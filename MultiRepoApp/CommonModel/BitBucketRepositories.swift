import Foundation

/// Represents BitBucket repositories.
struct BitBucketRepositories: Codable {
    let values: [BitValue]
}

struct BitValue: Codable {
    let name, description: String
    let owner: BitOwner
}

struct BitOwner: Codable {
    let displayName: String
    let links: Links
    let type: BitTypeEnum
    let uuid: String
    let accountID, nickname, username: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case links, type, uuid
        case accountID = "account_id"
        case nickname, username
    }
}

struct Links: Codable {
    let linksSelf, avatar, html: Avatar

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case avatar, html
    }
}

struct Avatar: Codable {
    let href: String
}

enum BitTypeEnum: String, Codable {
    case team
    case user
}
