import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: floatingText
    entityId: "floatingText"
    entityType: "floatingText"

    property int score: 0
    property int xp: 0
    property bool run: true

    width: floatingScore.width > floatingXp.width ? floatingScore.width: floatingXp.width
    height: floatingScore.height + floatingXp.height
    opacity: 1

    Text {
        id: floatingScore
        color: "#08dc05"
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        text: "+" + score + "pts"

    }
    Text {
        id: floatingXp
        anchors.top: floatingScore.bottom
        color: "yellow"
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        text: xp > 0 ? "+" + xp + "XP" : ""
    }

    NumberAnimation on opacity {
        to: 0
        running: run
        duration: 1500
        onStopped: removeEntity()  // TODO change this to a pooled entity
    }
}
