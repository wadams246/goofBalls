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
            scale: 1.2
            source: "../../assets/img/background.png"
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

    // back button to leave scene
    MenuButton {
        width: 20
        height: 20
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    Text {
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 2
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 2
        color: "white"
        font.pixelSize: 20
        text: "Score: " + player.score
    }

    Text {
        id: levelText
        anchors.centerIn: gameScene.gameWindowAnchorItem
        anchors.verticalCenterOffset: -75
        color: "yellow"
        font.pixelSize: 30
        text: "LEVEL " + player.level
        opacity: 1

        NumberAnimation on opacity {
            id: fadeLevelText
            to: 0
            duration: 2500
        }
    }

    Hud {
        anchors {
            bottom: gameScene.gameWindowAnchorItem.bottom

        }
    }

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

    function resetBalls() {
        gameRunning = false;
        balls = 1;
        countdown = 1;
        player.reset();
        ballGenInterval = 3500;
        player.hp = 100 + (100 * (player.level * .25))
        entityManager.removeEntitiesByFilter(["ball"]);
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
