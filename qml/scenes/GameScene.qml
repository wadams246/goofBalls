import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../hud"

SceneBase {
    id:gameScene

    property int balls: 1
    property int countdown: 1
    property int ballGenInterval: 3500
    property int lScaleMultiplier: 1
    property bool gameRunning: false


    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        Image {
            anchors.fill: parent
            source: "../../assets/img/background/dayBackground.png"
        }

        Image {
            id: duskSky
            anchors.fill: parent
            source: "../../assets/img/background/duskBackground.png"
            opacity: 0
        }
//        Image {
//            id: nightSky
//            anchors.fill: parent
//            source: "../../assets/img/background/nighBackground.png"
//            opacity: 0
//        }

        NumberAnimation on opacity {
            id: dayToDusk
            target: duskSky
            property: "opacity"
            from: 0
            to: 1
            duration: 120000
            running: false
            onStopped: {
                duskToDay.start();
            }
        }

        NumberAnimation on opacity {
            id: duskToDay
            target: duskSky
            property: "opacity"
            from: 1
            to: 0
            duration: 120000
            running: false
            onStopped: {
                dayToDusk.start();
            }
        }
//        NumberAnimation on opacity {
//            id: nightToDay
//            target: nightSky
//            property: "opacity"
//            from: 1
//            to: 0
//            duration: 120000
//            running: false
//            onStopped: {
//                dayToNight.start();
//            }
//        }
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
             cloud1.y = 10+Math.random()*200
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
             cloud2.y = 10+Math.random()*200
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
             cloud3.y = 30+Math.random()*200
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
             cloud4.y = 30+Math.random()*200
           }
         }
    }
    Wall {height:parent.height+50; anchors.right:parent.left}
    Wall {height:parent.height+50; anchors.left:parent.right}
    BallCollector {id: ballCollector; width:parent.width; anchors.top:parent.gameWindowAnchorItem.bottom; anchors.topMargin: 110}
    Ceiling {id: top; width:parent.width; anchors.bottom:parent.gameWindowAnchorItem.top; anchors.bottomMargin: 1}

    PhysicsWorld {
        debugDrawVisible: false
        gravity.y: 5
        z: 1000
    }

    HpBar {
        id: hpBar
        anchors {
            left: gameScene.gameWindowAnchorItem.left
            leftMargin: 2
            top: gameScene.gameWindowAnchorItem.top
            topMargin: 2
        }
    }

    XpBar {
        id: xpBar
        anchors {
            right: gameScene.gameWindowAnchorItem.right
            rightMargin: 2
            top: gameScene.gameWindowAnchorItem.top
            topMargin: 2
        }
    }

    // back button to leave scene
    MenuButton {
        width: 20
        height: 20
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 2
        anchors.top: xpBar.bottom
        anchors.topMargin: 2
        onClicked: backButtonPressed()
        text: "<<"
    }

    Text {
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 2
        anchors.top: hpBar.bottom
        color: "white"
        font.pixelSize: 16
        text: "Score: " + player.score
    }

    Text {
        id: levelText
        anchors.centerIn: gameScene.gameWindowAnchorItem
        anchors.verticalCenterOffset: -75
        color: "yellow"
        font.pixelSize: 40
        text: "LEVEL " + player.level
        opacity: 1

        NumberAnimation on opacity {
            id: fadeLevelText
            to: 0
            duration: 2500
        }
    }


//    Hud {
//        anchors {
//            bottom: gameScene.gameWindowAnchorItem.bottom
//        }
//    }

    // text displaying either the countdown or "tap!"
    Text {
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: countdown > 0 ? 120 : 18
        text: countdown > 0 ? countdown : ""
    }

    Timer {
        repeat: true
        running: countdown > 0 && window.state === "game" && gameRunning === false
        onTriggered: {
            countdown--
            if(countdown < 1) {
                gameRunning = true
                levelText.opacity = 1;
                fadeLevelText.start();
                entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/GreenBall.qml"));
//                entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/PowerUp.qml"));
            }
        }
    }

    Timer {
        interval: ballGenInterval
        running: gameRunning == true && window.state === "game"
        repeat: true
        onTriggered: {
//            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/SpeedBall.qml"));
            var rand = Math.floor(utils.generateRandomValueBetween(0, 101));

            switch(player.level) {
                case 1: ballGen.levelOne()
                    break;
                case 2: ballGen.levelTwo()
                    break;
                case 3: ballGen.levelThree()
                    break;
                case 4: ballGen.levelFour()
                    break;
                default: ballGen.levelPlus(player.level)
                    console.debug("LEVELPLUSS CALLED");
                    break;
            }

            balls++
        }
     }

    function resetBackground() {
        dayToDusk.restart();
        duskSky.opacity = 0;
        dayToDusk.start();
    }

    function resetBalls() {
        gameRunning = false;
        balls = 1;
        countdown = 1;
        player.reset();
        ballGenInterval = 3000;
        player.hp = 100 + (100 * (player.level * .25))
        entityManager.removeEntitiesByFilter(["ball"]);
        resetBackground();
    }

    function changeInterval() {
        ballGenInterval = (ballGenInterval * .9 < 1000) ? 1000 : ballGenInterval *= .9
    }

    function showLevelText(lvl) {
        levelText.opacity = 1;
        levelText.text = "LEVEL " + player.level;
        fadeLevelText.start();
    }
}
