import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../hud"
import "../entities/Balls"

SceneBase {
    id: tutorialScene

    signal skipPressed

    property bool skip: false
    property int count: 0

    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "#000000"
        opacity: .6
    }
    EntityManager {
        id: tutEntityMnger
        entityContainer: tutorialScene
    }
    Hud {
        id: hud
        anchors {
            left: parent.gameWindowAnchorItem.left
            leftMargin: 2
            top: parent.gameWindowAnchorItem.top
            topMargin: 2
        }
        opacity: 0
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
        id: intro
        anchors.centerIn: parent
        text: "Click next to begin tutorial \nor skip to begin playing."
        color: "#ffffff"
        font.pixelSize: 14
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
    }
    Tutorial {
        id: pauseTut

        anchors {
            left: hud.right
            top: hud.bottom
        }

        tutText: "Click the player status \nbar at any time \nto pause the game"
        opacity: 0
    }
    Tutorial {
        id: ballSpawn

        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            left: parent.left
            leftMargin: 10
        }

        tutText: "Balls will pop up \nfrom the bottom"
        opacity: 0
    }
    Tutorial {
        id: ballBounce

        anchors.centerIn: parent

        tutText: "Tap to bounce the balls \nso they don't fall off \n the screen."
        opacity: 0
    }
    Tutorial {
        id: ballHeal

        anchors {
            top: parent.top
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        tutText: "If you tap the balls\ntoo high, they will\nheal themselves."
        opacity: 0
    }
    Tutorial {
        id: keepMiddle

        anchors.centerIn: parent

        tutText: "Try to keep the balls\nin the middle of the\nscreen until they pop."
        opacity: 0
    }
    Rectangle {

        MenuButton {
            id: nextButton

            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                right: parent.right
                rightMargin: 10
            }

            text: "NEXT"
            width: 80
            lightColor: "#7aef76"
            darkColor: "#00d209"
            borderColor: "#009210"
            onClicked: {
                next();
            }
        }
        MenuButton {
            id: skipTutorial
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                right: nextButton.left
                rightMargin: 2
            }
            text: "SKIP"
            width: 80
            lightColor: "#ff7db2"
            darkColor: "#f50030"
            borderColor: "#a5002e"
            onClicked: {
                skipPressed();
                skip = true;
            }
        }
    }


    function next() {
        count++;
        switch(count) {
        case 1:
            showPauseTut();
            break;
        case 2:
            showBallSpawn();
            break;
        case 3:
            showBallHeal();
            break;
        case 4:
            showKeepMiddle();
            break;
        }
    }

    function showPauseTut() {
        resetAll();
        hud.opacity = 1;
        pauseTut.opacity = 1;
        intro.opacity = 0;
    }

    function showBallSpawn() {
        resetAll();
        ballSpawn.opacity = 1;
    }

    function showBallBounce() {
        resetAll();
        ballBounce.opacity = 1;
    }

    function showBallHeal() {
        resetAll();
        ballHeal.opacity = 1;
    }

    function showKeepMiddle() {
        resetAll();
        keepMiddle.opacity = 1;
    }

    function genBall() {
        hud.opacity = 0;
        tutEntityMnger.createEntityFromUrl(Qt.resolvedUrl("../entities/Balls/TutorialBall.qml"));
//        system.pauseGameForObject(tutorialScene);
    }

    function resetAll() {
        hud.opacity = 0;
        pauseTut.opacity = 0;
        ballSpawn.opacity = 0;
        ballBounce.opacity = 0;
        ballHeal.opacity = 0;
        keepMiddle.opacity = 0;
    }
}
