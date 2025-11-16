import Foundation

struct TeamModel: Identifiable {
    let id: UUID
    let name: String
    let players: [PlayerModel]

    func update(id: UUID, name: String, players: [PlayerModel]) -> TeamModel {
        TeamModel(id: id, name: name, players: players)
    }
}
