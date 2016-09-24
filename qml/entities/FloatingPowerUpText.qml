import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: floatingText
    entityType: "floatingPowerUpText"

    property int hp: 0
    property string text: "sample text"


    Text {
        id: pwrUpText
        color: "#08dc05"
        font.pixelSize: 8
        font.bold: true
        text: floatingText.text
        opacity: 1

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
}
