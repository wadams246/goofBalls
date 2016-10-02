import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityType: "wall"
    width: 1
    height: 1

    BoxCollider {
        categories: Box.Category2
        anchors.fill: parent
        bodyType: Body.Static
        friction: .25
    }

}
