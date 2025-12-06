import Foundation
import SwiftData

@Model
final class PlayerEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var team: String
    var photoData: Data?

    init(
        id: UUID = UUID(),
        name: String,
        team: String,
        photoData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.team = team
        self.photoData = photoData
    }
}

extension PlayerEntity {
    func toModel() -> PlayerModel {
        PlayerModel(
            id: id,
            name: name,
            team: team,
            photoData: photoData
        )
    }
}
