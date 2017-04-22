import VPlay 2.0
import QtQuick 2.0

Item {

    id: bigCloud

    property int num: Math.random() * 3 + 4;
    property real xPos: 0;

    Image {
        id: cloudImg
        height: implicitHeight * .35
        width: implicitWidth * .35
        x: xPos
        y: Math.random() * 40
        source: "../../assets/img/background/cloud" + num + ".png"
    }

    MovementAnimation {
       id: cloudMovment
       target: cloudImg
       property: "x"
       minPropertyValue: -cloudImg.width
       velocity: -10
       running: true
       onLimitReached: {
         cloudImg.x = menuScene.gameWindowAnchorItem.width
         cloudImg.y = Math.random() * 40
       }
     }
}
