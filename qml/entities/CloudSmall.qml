import VPlay 2.0
import QtQuick 2.0

Item {

    id: smallCloud

    property int num: Math.random() * 3 + 4;
    property real xPos: 0;

    Image {
        id: cloudImg
        height: implicitHeight * .25
        width: implicitWidth * .25
        x: xPos
        y: Math.random() * 50 + 30
        opacity: .8
        source: "../../assets/img/background/cloud" + num + ".png"

    }

    MovementAnimation {
       id: cloudMovement
       target: cloudImg
       property: "x"
       minPropertyValue: -cloudImg
       velocity: -5
       running: true
       onLimitReached: {
         cloudImg.x = menuScene.gameWindowAnchorItem.width
         cloudImg.y = Math.random() * 50 + 30
       }
    }
}
