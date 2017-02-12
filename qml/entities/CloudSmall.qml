import VPlay 2.0
import QtQuick 2.0

Item {

    id: smallCloud

    property int num: Math.random() * 2 + 1;
    property real xPos: 0;

    Image {
        id: cloudImg
        height: 151 * .25
        width: 249 * .25
        x: xPos
        y: 5 + Math.random() * 100
        opacity: .8
        source: "../../assets/img/background/cloud" + num + ".png"

    }

    MovementAnimation {
       id: cloudMovement
       target: cloudImg
       property: "x"
       minPropertyValue: -249 * .25
       velocity: -5
       running: true
       onLimitReached: {
         cloudImg.x = menuScene.width
         cloudImg.y = 10 + Math.random() * 100
       }
    }


}
