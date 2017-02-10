import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    signal creditsPressed
    signal scoresPressed
    signal optionsPressed
    signal playPressed
    signal exitPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        Image {
            anchors.fill: parent
            source: "../../assets/img/background/dayBackground.png"
        }

        Image {
            id: cloud1
            height: 151 * .25
            width: 249 * .25
            x: menuScene.width
            y: 10
            opacity: .8
            source: "../../assets/img/background/cloud1.png"
        }

        MovementAnimation {
           id: cloud1Movment
           target: cloud1
           property: "x"
           minPropertyValue: -249 * .25
           velocity: -5
           running: true
           onLimitReached: {
             cloud1.x = menuScene.width
             cloud1.y = 10+Math.random()*100
           }
        }
        Image {
            id: cloud2
            height: 151 * .25
            width: 249 * .25
            x: menuScene.width / 2
            y: 50
            opacity: .8
            source: "../../assets/img/background/cloud2.png"
        }

        MovementAnimation {
           id: cloud2Movment
           target: cloud2
           property: "x"
           minPropertyValue: -249 * .25
           velocity: -5
           running: true
           onLimitReached: {
             cloud2.x = menuScene.width
             cloud2.y = 10+Math.random()*100
           }
        }
        Image {
            id: cloud3
            height: 151 * .40
            width: 249 * .40
            x: menuScene.width / 2
            y: 75
            source: "../../assets/img/background/cloud1.png"
        }

        MovementAnimation {
           id: cloud3Movment
           target: cloud3
           property: "x"
           minPropertyValue: -249 * .40
           velocity: -10
           running: true
           onLimitReached: {
             cloud3.x = menuScene.width
             cloud3.y = 30+Math.random()*100
           }
         }
        Image {
            id: cloud4
            height: 151 * .40
            width: 249 * .40
            x: menuScene.width + 100
            y: 30
            source: "../../assets/img/background/cloud2.png"
        }

        MovementAnimation {
           id: cloud4Movment
           target: cloud4
           property: "x"
           minPropertyValue: -249 * .40
           velocity: -10
           running: true
           onLimitReached: {
             cloud4.x = menuScene.width
             cloud4.y = 30+Math.random()*100
           }
         }
    }

    // the "logo"
    Item {
        id: logo
        width: 250
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        y: 80

        Image {
            id: logoImg
            anchors.fill: parent
            source: "../../assets/img/logo/goofballsTitle.png"
        }
    }

//    Text {
//        anchors.horizontalCenter: parent.horizontalCenter
//        y: 50
//        font.pixelSize: 60
//        color: "#e9e9e9"
//        text: "Goofballs"
//    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 1
        MenuButton {
            text: "Play"
            onClicked: playPressed()
        }
        MenuButton {
            text: "Options"
            onClicked: optionsPressed()
        }
        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }
        MenuButton {
            text: "High Scores"
            onClicked: scoresPressed()
        }
        MenuButton {
            text: "Exit"
            onClicked: exitPressed()
        }
    }

}
