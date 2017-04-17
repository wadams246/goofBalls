import VPlay 2.0
import QtQuick 2.0
import "../scenes"
import "../common"

EntityBase {

    entityType: "ballCollector"
    width: 1
    height: 1

    BoxCollider {
        categories: Box.Category3
        anchors.fill: parent
        bodyType: Body.Static
        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            entityManager.removeEntityById(collidedEntity.entityId)
            player.hp -= collidedEntity.dmgPoints

            if(player.hp < 1) {
                entityManager.removeEntitiesByFilter(["ball"])
                gameScene.gameRunning = false
                window.state = "gameOver"
            }
        }
    }
}
