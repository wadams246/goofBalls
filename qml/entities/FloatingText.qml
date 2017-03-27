import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: floatingText
    entityId: "floatingText"
    entityType: "floatingText"

    property int score: 0
    property int xp: 0

    Text {
        id: floatingScore
        color: "#08dc05"
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        text: "+" + score + "pts"
        opacity: 1

        Text {
            id: floatingXp
            anchors.top: floatingScore.bottom
            color: "yellow"
            style: Text.Outline
            styleColor: "#000000"
            font.pixelSize: 14
            text: xp > 0 ? "+" + xp + "XP" : ""
            opacity: 1
        }

        NumberAnimation on opacity {
            to: 0
            duration: 1500
            onStopped: removeEntity()  // TODO change this to a pooled entity
        }
    }

}
