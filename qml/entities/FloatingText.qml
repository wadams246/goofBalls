import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityId: "floatingText"
    entityType: "floatingText"

    property int score: 0
    property int xp: 0

    Text {
        id: floatingScore
        color: "#08dc05"
        font.pixelSize: 8
        font.bold: true
        text: "+" + score + "pts"
        opacity: 1

        Text {
            id: floatingXp
            anchors.top: floatingScore.bottom
            color: "yellow"
            font.pixelSize: 8
            font.bold: true
            text: xp > 0 ? "+" + xp + "xp" : ""
            opacity: 1

            NumberAnimation on opacity {
                to: 0
                duration: 1500
            }
        }

        NumberAnimation on opacity {
            to: 0
            duration: 1500
            onStopped: removeEntity()  // TODO change this to a pooled entity
        }
        NumberAnimation on y {
            to: -25
            duration: 1000
        }
    }

    function getScore(s) {
        score = s
        floatingScore.opacity = 1
        floatingScore.start()
    }
}
