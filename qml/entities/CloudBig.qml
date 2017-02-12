import VPlay 2.0
import QtQuick 2.0

Item {

    id: bigCloud

    property int num: Math.random() * 2 + 1;
    property real xPos: 0;

    Image {
        id: cloudImg
        height: 151 * .40
        width: 249 * .40
        x: xPos
        y: 10 + Math.random() * 115
        source: "../../assets/img/background/cloud" + num + ".png"
    }

    MovementAnimation {
       id: cloudMovment
       target: cloudImg
       property: "x"
       minPropertyValue: -249 * .40
       velocity: -10
       running: true
       onLimitReached: {
         cloudImg.x = menuScene.width
         cloudImg.y = 30 + Math.random() * 100
       }
     }


}
