import VPlay 2.0
import QtQuick 2.0
import "../common"

// EMPTY SCENE
SceneBase {
    id: countDownScene

    signal startGame
    signal resumeGame

    property int countdown: 3
    property bool newGame: true
    property bool started: false

    // in-game back button
    MouseArea {
        id: backButton

        width: 100
        height: 34

        anchors {
            left: countDownScene.gameWindowAnchorItem.left
            leftMargin: 2
            top: countDownScene.gameWindowAnchorItem.top
            topMargin: 2
        }
        onPressed: backButtonPressed()
    }


    Item {
        id: countDown

        anchors.centerIn: parent

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

        Timer {
            repeat: true
            running: countdown > 0 && window.state === "countDown"
            onTriggered: {
                decCount();
                if(countdown < 1) {
                    if(newGame || !started) {
                        console.log('newgame');
                        startGame();
                    } else {
                        console.log('oldgame');
                        resumeGame();
                    }
                }
            }
        }
    }

    function resetCount() {
        countdown = 3;
        countDownText.opacity = 1;
        countDownText.font.pixelSize = 80;
        fadeCountDown.start();
        resizeFont.start();
    }
    function decCount() {
        countdown--;
        fadeCountDown.stop();
        resizeFont.stop();
        countDownText.opacity = 1;
        countDownText.font.pixelSize = 80;
        fadeCountDown.start();
        resizeFont.start();
    }
}



