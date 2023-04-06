import Foundation

struct Crew: Decodable {
    let name: String
    let department: String
    let job: String

    private enum CodingKeys: String, CodingKey {
        case name
        case department
        case job
    }
}
