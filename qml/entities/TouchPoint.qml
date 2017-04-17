import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: touchPoint
    entityType: "touch"

    width: 50

    CircleCollider {
        id: touchCollider
        radius: parent.width / 2
        categories: Circle.Category4
        collisionTestingOnlyMode: true
    }

    Timer {
        interval: 100
        repeat: false
        running: true
        onTriggered: {
            removeEntity();
        }
    }
}
