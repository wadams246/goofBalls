import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../hud"

SceneBase {
    id:gameScene

    property int balls: 1
    property int countdown: 3
    property int ballGenInterval: 3500
    property int lScaleMultiplier: 1
    property bool gameRunning: false

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        Image {
            anchors.fill: parent
            source: "../../assets/img/background/newBg.png"
        }

//        Image {
//            id: duskSky
//            anchors.fill: parent
//            source: "../../assets/img/background/duskBackground.png"
//            opacity: 0
//        }
//        Image {
//            id: nightSky
//            anchors.fill: parent
//            source: "../../assets/img/background/nighBackground.png"
//            opacity: 0
//        }

//        NumberAnimation on opacity {
//            id: dayToDusk
//            target: duskSky
//            property: "opacity"
//            from: 0
//            to: 1
//            duration: 120000
//            running: false
//            onStopped: {
//                duskToDay.start();
//            }
//        }

//        NumberAnimation on opacity {
//            id: duskToDay
//            target: duskSky
//            property: "opacity"
//            from: 1
//            to: 0
//            duration: 120000
//            running: false
//            onStopped: {
//                dayToDusk.start();
//            }
//        }
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
        Clouds {
            id: clouds
        }
    }
    Wall {height:parent.height+50; anchors.right:parent.left}
    Wall {height:parent.height+50; anchors.left:parent.right}
    BallCollector {id: ballCollector; width:parent.width; anchors.top:parent.gameWindowAnchorItem.bottom; anchors.topMargin: 130}
    Ceiling {id: top; width:parent.width; anchors.bottom:parent.gameWindowAnchorItem.top; anchors.bottomMargin: 1}

    PhysicsWorld {
        debugDrawVisible: false
        gravity.y: 5
        z: 1000
    }

    Hud {
        id: hud
        anchors {
            left: gameScene.gameWindowAnchorItem.left
            leftMargin: 2
            top: gameScene.gameWindowAnchorItem.top
            topMargin: 2
        }
        // in-game back button
        MouseArea {
            id: backButton
            anchors.centerIn: hud
            width: hud.width
            height: hud.height
            onPressed: backButtonPressed()
        }
    }

    Text {
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 2
        anchors.top: gameScene.gameWindowAnchorItem.top
        color: "white"
        style: Text.Outline
        styleColor: "#000000"
        font.pixelSize: 14
        font.family: riffic.name
        text: "SCORE: " + player.score
    }

    Text {
        id: levelText
        anchors.centerIn: gameScene.gameWindowAnchorItem
        anchors.verticalCenterOffset: -75
        font.family: riffic.name
        font.pixelSize: 50
        color: "yellow"
        style: Text.Outline
        styleColor: "#a86800"
        opacity: 1
        text: "LEVEL " + player.level

        NumberAnimation on opacity {
            id: fadeLevelText
            to: 0
            duration: 2500
        }
    }

    // text displaying either the countdown or "tap!"
    Text {
        id: countDownText
        anchors.centerIn: parent
        color: "white"
        font.family: riffic.name
        style: Text.Outline
        styleColor: "#0015c5"
        font.pixelSize: 80
        opacity: 1
        text: countdown > 0 ? countdown : ""

        NumberAnimation on opacity {
            id: fadeCountDown
            to: .2
            duration: 1000
        }
        NumberAnimation on font.pixelSize {
            id: resizeFont
            to: 60
            duration: 1000
        }
    }

    Text {
        id: goText
        anchors.centerIn: parent
        color: "white"
        font.family: riffic.name
        style: Text.Outline
        styleColor: "#0015c5"
        font.pixelSize: 80
        opacity: 0
        text: countdown > 0 && goText.opacity > 0 ? "" : "GO!"

        NumberAnimation on opacity {
            id: fadeGo
            to: 0
            duration: 2500
        }
        NumberAnimation on font.pixelSize {
            id: resizeGo
            to: 60
            duration: 1000
        }
    }

    Timer {
        repeat: true
        running: countdown > 0 && window.state === "game" && gameRunning === false
        onTriggered: {
            decCount();
            if(countdown < 1) {
                gameRunning = true
                levelText.opacity = 1;
                fadeLevelText.start();
                goText.opacity = 1;
                fadeGo.start();
                resizeGo.start();
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

//    function resetBackground() {
//        dayToDusk.restart();
//        duskSky.opacity = 0;
//        dayToDusk.start();
//    }

    function resetBalls() {
        gameRunning = false;
        balls = 1;
        countdown = 3;
        resetCount();
        player.reset();
        ballGenInterval = 3000;
        entityManager.removeEntitiesByFilter(["ball"]);
//        resetBackground();
    }

    function changeInterval() {
        ballGenInterval = (ballGenInterval * .9 < 1000) ? 1000 : ballGenInterval *= .9
    }

    function showLevelText(lvl) {
        levelText.opacity = 1;
        levelText.text = "LEVEL " + player.level;
        fadeLevelText.start();
    }
    function resetCount() {
        countDownText.opacity = 1;
        countDownText.font.pixelSize = 80;
        goText.opacity = 0;
        goText.font.pixelSize = 80;
        fadeCountDown.start();
        resizeFont.start();
        fadeGo.start();
        resizeGo.start();
    }
    function decCount() {
        countdown--;
        fadeCountDown.stop();
        resizeFont.stop();
        fadeGo.stop();
        resizeGo.stop();
        countDownText.opacity = 1;
        countDownText.font.pixelSize = 80;
        fadeCountDown.start();
        resizeFont.start();
    }
}
