import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: dmgText
    entityId: "floatingText"
    entityType: "floatingText"

    z: 5
    property int dmg: 0
    property int xp: 0

    Text {
        id: text
        color: "#f50030"
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 12
        text: dmg
        opacity: 1

        NumberAnimation on opacity {
            to: 0
            duration: 1000
            onStopped: removeEntity()  // TODO change this to a pooled entity
        }
    }
}
