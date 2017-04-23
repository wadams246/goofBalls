import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: popName
    entityId: "popName"

    width: name.width
    height: name.height + popTotal.height
    opacity: 1

    property variant popNames: ['DOUBLE', 'TRIPLE', 'SUPER', 'AWESOME', 'AMAZING', 'INSANE', 'KILLER', 'ULTRA']
    property int popCount: 0

    Text {
        id: name
        anchors.centerIn: parent
        color: "#ffffff"
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 30
        text: popCount > 8 ? popNames[7] + " POP" : popNames[popCount - 2] + " POP"
    }

    Text {
        id: popTotal
        anchors.top: name.bottom
        anchors.horizontalCenter: name.horizontalCenter
        color: "#ffffff"
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 16
        text: popCount + " Popped!"
    }

    NumberAnimation on opacity {
        id: popNameAnim
        to: 0
        duration: 1500
//        onStopped: removeEntity()  // TODO change this to a pooled entity
    }

    function showName(count) {
        popNameAnim.stop();
        popName.opacity = 1;
        popName.popCount = count;
        popNameAnim.start();
    }
}
