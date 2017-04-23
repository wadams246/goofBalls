import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: touchPoint
    entityId: "touchPoint"
    entityType: "touch"

    width: 50

    signal multiPop(int count)
    property int hitCount: 0
    property int popCount: 0
    property int hitPoints: 0
    property int popPoints: 0
    property int xp: 0

    CircleCollider {
        id: touchCollider
        radius: parent.width / 2
        categories: Circle.Category4
        collisionTestingOnlyMode: true
    }

    Timer {
        interval: 10
        repeat: false
        running: true
        onTriggered: {
            var totalHitPoints = hitPoints * hitCount;
            var totalPopPoints = popPoints * popCount;
            if(popPoints > 0) {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingText.qml"), {
                                                                    "x": x,
                                                                    "y": y,
                                                                    "score": popCount > 1 ? totalPopPoints + "pts(" + popCount + "x)": totalPopPoints + "pts",
                                                                    "xp": xp + "xp"
                                                                });
            }
            if(popCount > 1) {
                multiPop(popCount);
            }
            player.score += (totalHitPoints + totalPopPoints);
            removeEntity();
        }
    }
}
