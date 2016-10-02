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

    property point ballCenter: mapFromItem(ball, ball.width * 0.5, ball.height * 0.5)
    property point entityCenter: mapFromItem(entity, entity.width * 0.5, entity.height * 0.5)

    Item {
        id: nonRotatedItem

        LineItem {
            color: "#0099ff"
            lineWidth: 3
            points: [
                {"x": ball !== null ? ballCenter.x : 0, "y": ball !== null ? ballCenter.y : 0},
                {"x": entity !== null ? entityCenter.x : 0, "y": entity !== null ? entityCenter.y : 0}
            ]
        }

        NumberAnimation on opacity {
            to: 0
            duration: 700
            onStopped: removeEntity()
            running: entity !== null && ball !== null
        }

    }

    // This may not be the best way to stop the healbolts from rotating.
    // I'm not sure how this is going to effect performance
    Timer {
        interval: 1
        running: nonRotatedItem.opacity > 0
        onTriggered:  {
            ballCenter = mapFromItem(ball, ball.width * 0.5, ball.height * 0.5)
            entityCenter = mapFromItem(entity, entity.width * 0.5, entity.height * 0.5)
        }
    }

}
