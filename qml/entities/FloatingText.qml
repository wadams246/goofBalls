import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: floatingText
    entityId: "floatingText"
    entityType: "floatingText"

    property alias score: floatingScore.text
    property alias xp: floatingXp.text
    property bool run: true


    width: floatingScore.width > floatingXp.width ? floatingScore.width: floatingXp.width
    height: floatingScore.height + floatingXp.height
    opacity: 1

    Text {
        id: floatingScore
        anchors.centerIn: parent
        color: "#ffffff"
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        text: ""

    }
    Text {
        id: floatingXp
        anchors.top: floatingScore.bottom
        anchors.horizontalCenter: floatingScore.horizontalCenter
        color: "yellow"
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        text: ""
    }

    NumberAnimation on opacity {
        to: 0
        running: run
        duration: 1500
        onStopped: removeEntity()  // TODO change this to a pooled entity
    }
}
