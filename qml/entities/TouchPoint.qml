import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: touchPoint
    entityType: "touch"

    width: 50

    property int hitCount: 0
    property int killCount: 0
    property int hitPoints: 0
    property int killPoints: 0
    property int xp: 0

    CircleCollider {
        id: touchCollider
        radius: parent.width / 2
        categories: Circle.Category4
        collisionTestingOnlyMode: true
    }

    Timer {
        interval: 50
        repeat: false
        running: true
        onTriggered: {
            console.debug("TOUCH HIT COUNT: ", hitCount);
            if(killPoints > 0) {
                var totalKillPoints = killPoints * killCount;
                player.score += totalKillPoints;
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingText.qml"), {
                                                                    "x": x,
                                                                    "y": y,
                                                                    "score": killCount > 1 ? totalKillPoints + "pts(" + killCount + "x)": totalKillPoints + "pts",
                                                                    "xp": xp + "xp"
                                                                });
            }

            removeEntity();
        }
    }
}
