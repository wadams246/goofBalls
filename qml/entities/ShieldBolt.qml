import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: shieldBolt
    entityType: "spellEffect"

    property int startX: 0
    property int startY: 0
    property int endX: 100
    property int endY: 100
    property int lastX: 0
    property int lastY: 0
    property variant ball: "ball"
    property variant entity: "entity"

    LineItem {
        color: "#0099ff"
        lineWidth: 3
        points: [
            {"x": ball !== null ? ball.x + ball.width / 2 : 0, "y": ball !== null ? ball.y + ball.height / 2 : 0},
            {"x": entity !== null ? entity.x + entity.width / 2 : 0, "y": entity !== null ? entity.y + entity.height / 2 : 0}
        ]
    }

    NumberAnimation on opacity {
        to: 0
        duration: 700
        onStopped: removeEntity()
        running: entity !== null && ball !== null
    }
}
