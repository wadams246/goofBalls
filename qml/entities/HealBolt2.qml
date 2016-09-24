import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: healBolt
    entityType: "spellEffect"

    width: 500

    property int startX: 0
    property int startY: 0
    property int endX: 100
    property int endY: 100
    property int lastX: 0
    property int lastY: 0
    property variant ball: "ball"
    property variant entity: "entity"

//    LineItem {
//        color: "#08dc05"
//        lineWidth: 3
//        points: [
//            {"x": ball.x + ball.width / 2, "y": ball.y + ball.height / 2},
//            {"x": entity.x + entity.width / 2, "y": entity.y + entity.height / 2}
//        ]
//    }
    MultiResolutionImage {
        id: healBoltImg
        source: "../../assets/img/healBolt.png"
    }

    PropertyAnimation on x {
        from: ball.x
        to: entity.x
        duration: 500

    }

    PropertyAnimation on y {
        from: ball.y
        to: entity.y
        duration: 500
        onStopped: removeEntity()
    }
}
