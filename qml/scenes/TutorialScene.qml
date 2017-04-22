import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../hud"
import "../entities"
import "../entities/Balls"

SceneBase {
    id: tutorialScene

    signal skipPressed
    signal menuPressed
    signal playPressed

    property int count: 0
    property int hitDelayCount: 0
    property int healDelayCount: 0
    property int power: 10
    property bool started: false

    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "#000000"
        opacity: .6
    }

    TutorialBall {
        id: tutBall
        x: -100
        y: 0
        opacity: 0
    }
    TutorialBall {
        id: tutBall2
        x: -100
        y: 0
        opacity: 0
    }
    TutorialBall {
        id: tutBall3
        x: -100
        y: 0
        opacity: 0
    }

    FloatingText {
        id: floatingText
        entityId: "floatingTutText"
        height: 60
        anchors.centerIn: tutorialScene
        opacity: 0
        run: false
        score: "100PTS"
        xp: "100XP"
    }

    Text {
        id: levelText
        anchors.centerIn: tutorialScene
        anchors.verticalCenterOffset: -75
        font.family: riffic.name
        font.pixelSize: 50
        color: "yellow"
        style: Text.Outline
        styleColor: "#a86800"
        opacity: 0
        text: "LEVEL 2"
    }

    Text {
        id: gameOverText

        anchors {
            centerIn: tutorialScene
            verticalCenterOffset: -75
        }

        opacity: 0
        text: "GAME OVER"
        font.family: riffic.name
        font.pixelSize: 42
        color: "#f50030"
        style: Text.Outline
        styleColor: "#a5002e"
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
    }

    Text {
        id: intro
        anchors.centerIn: parent
        text: "Tap next to begin tutorial \nor skip to begin playing."
        color: "#ffffff"
        font.pixelSize: 14
        font.family: riffic.name
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "#000000"
    }

    Tutorial {
        id: playerStatus

        anchors {
            left: hud.right
            top: hud.bottom
        }

        tutText: "This is your player status.\nIt shows you your current\nlevel, health and experience."
        opacity: 0
    }

    Tutorial {
        id: pauseTut

        anchors {
            left: hud.right
            top: hud.bottom
        }

        tutText: "Tap the player status \nat any time to \npause the game"
        opacity: 0
    }

    Tutorial {
        id: ballSpawn

        anchors {
            right: tutBall.left
            rightMargin: -20
            bottom: tutBall.top
        }

        tutText: "Balls will pop \nup from the bottom\n of the screen."
        opacity: 0
    }

    Tutorial {
        id: ballBounce

        anchors.top: tutBall.bottom
        anchors.horizontalCenter: tutBall.horizontalCenter

        tutText: "Tap the balls to bounce\n them up to keep them from\n falling off the bottom\n of the screen."
        opacity: 0
    }

    Tutorial {
        id: ballDmg

        anchors.top: tutBall.bottom
        anchors.horizontalCenter: tutBall.horizontalCenter

        tutText: "Everytime you tap a ball\nthey will take damage\n and you will earn points."
        opacity: 0
    }

    Tutorial {
        id: multiHit

        anchors.top: tutBall2.bottom
        anchors.horizontalCenter: tutBall.horizontalCenter

        tutText: "Multiple balls can be\n hit with one tap. Your\n tap points will be\n multipled by that number."
        opacity: 0
    }

    Tutorial {
        id: ballHeal

        anchors.top: tutBall.bottom
        anchors.horizontalCenter: tutBall.horizontalCenter

        tutText: "If you tap the balls high\n enough to touch the top\n of the screen, the balls\n will heal themselves."
        opacity: 0
    }

    Tutorial {
        id: keepMiddle

        anchors.top: tutBall.bottom
        anchors.horizontalCenter: tutBall.horizontalCenter

        tutText: "Try to keep the balls\nin the middle of the\nscreen until they pop."
        opacity: 0
    }

    Tutorial {
        id: ballPopped

        anchors {
            top: floatingText.bottom
            horizontalCenter: floatingText.horizontalCenter
        }

        tutText: "You will receive points\nand experience everytime\nyou pop a ball. Those points\n will be multiplied by the\n number of balls you\n popped with one tap."
        opacity: 0
    }

    Tutorial {
        id: newLevel

        anchors.top: levelText.bottom
        anchors.horizontalCenter: levelText.horizontalCenter

        tutText: "As you gain experience your level\n will increase. Everytime your level\n increases, your HP will be restored to full\n and your tap power will increase."
        opacity: 0
    }

    Tutorial {
        id: uniqueBalls

        anchors {
            top: tutorialScene.top
            topMargin: 10
            horizontalCenter: tutorialScene.horizontalCenter
        }

        tutText: "There are different colored balls that each\n have their own attributes and abilities"
        opacity: 0

        BallList1 {
            id: ballList1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: uniqueBalls.bottom
            width: tutorialScene.width
            height: tutorialScene.height
            opacity: 1
        }

        BallList2 {
            id: ballList2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: uniqueBalls.bottom
            width: tutorialScene.width
            height: tutorialScene.height
            opacity: 0
        }
    }

    Tutorial {
        id: gameOver

        anchors.top: gameOverText.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: gameOverText.horizontalCenter

        tutText: "The game will end when your\n health reaches zero."
        opacity: 0
    }

    Tutorial {
        id: end

        anchors.centerIn: tutorialScene

        tutText: "This completes the tutorial."
        opacity: 0
    }

    Rectangle {
        id: buttonsContainer

        anchors {
            top: intro.bottom
            topMargin: 10
            horizontalCenter: intro.horizontalCenter
        }

        color: "transparent"
        width: nextButton.width + exitButton.width + 2
        height: nextButton.height

        MenuButton {
            id: exitButton

            anchors {
                bottom: buttonsContainer.bottom
                left: buttonsContainer.left
            }

            text: "SKIP"
            width: 80
            lightColor: "#ff7db2"
            darkColor: "#f50030"
            borderColor: "#a5002e"
            onClicked: {
                if(count === 14) {
                    skipPressed();
                    menuPressed();
                } else {
                    playPressed();
                }
            }
        }

        MenuButton {
            id: nextButton

            anchors {
                bottom: buttonsContainer.bottom
                right: buttonsContainer.right
            }

            text: "NEXT"
            width: 80
            lightColor: "#7aef76"
            darkColor: "#00d209"
            borderColor: "#009210"
            onClicked: {
                if(count === 14) {
                    playPressed();
                } else {
                    next();
                }
            }
        }
    }

    Timer {
        id: hitDelay
        interval: 1200
        repeat: false
        running: hitDelayCount > 0 && window.state === "tutorial"
        onTriggered: {
            hitDelayCount--;
            tutBall.bounce(power);
            tutBall2.bounce(power);
            tutBall3.bounce(power);
        }
    }
    Timer {
        id: healDelay
        interval: 1200
        repeat: false
        running: healDelayCount > 0 && window.state === "tutorial"
        onTriggered: {
            healDelayCount--;
            tutBall.heal(15);
        }
    }

    function next() {
        count++;
        switch(count) {
            case 1:
                showPlayerStatus();
                break;
            case 2:
                showPauseTut();
                break;
            case 3:
                showBallSpawn();
                break;
            case 4:
                showBallBounce();
                break;
            case 5:
                showBallDmg();
                break;
            case 6:
                showMultiHit();
                break;
            case 7:
                showBallHeal();
                break;
            case 8:
                showKeepMiddle();
                break;
            case 9:
                showBallPopped();
                break;
            case 10:
                showNewLevel();
                break;
            case 11:
                showUniqueBalls(true);
                break;
            case 12:
                showUniqueBalls(false);
                break;
            case 13:
                showGameOver();
                break;
            case 14:
                showEnd();
                break;
            default:
                showIntro();
                break;
        }
    }

    function moveButtonsBottom() {
        buttonsContainer.width = tutorialScene.width - 20;
        buttonsContainer.anchors.top = undefined;
        buttonsContainer.anchors.topMargin = undefined;
        buttonsContainer.anchors.bottom = tutorialScene.gameWindowAnchorItem.bottom;
        buttonsContainer.anchors.bottomMargin = 10;
    }

    function moveButtonsTop() {
        if(count === 0) {
            nextButton.text = "NEXT";
            exitButton.text = "SKIP";
        } else {
            nextButton.text = "PLAY";
            exitButton.text = "EXIT";
        }

        buttonsContainer.width = nextButton.width + exitButton.width + 2
        buttonsContainer.anchors.bottom = undefined;
        buttonsContainer.anchors.bottomMargin = undefined;
        buttonsContainer.anchors.top = end.bottom;
        buttonsContainer.anchors.topMargin = 10;
        buttonsContainer.anchors.horizontalCenter = end.horizontalCenter;
    }

    function showIntro() {
        resetAll();
        intro.opacity = 1;
        moveButtonsTop();
    }

    function showPlayerStatus() {
        resetAll();
        player.hp = 75;
        player.xp = 200;
        hud.opacity = 1;
        playerStatus.opacity = 1;
        moveButtonsBottom();
    }

    function showPauseTut() {
        resetAll();
        hud.opacity = 1;
        pauseTut.opacity = 1;
    }

    function showBallSpawn() {
        resetAll();
        ballSpawn.opacity = 1;
        tutBall.opacity = 1;
        tutBall.anchors.horizontalCenter =  tutorialScene.horizontalCenter;
        tutBall.anchors.bottom = tutorialScene.gameWindowAnchorItem.bottom;
    }

    function showBallBounce() {
        resetAll();
        tutBall.opacity = 1;
        tutBall.anchors.bottom = undefined;
        tutBall.anchors.centerIn = tutorialScene;
        ballBounce.opacity = 1;
    }

    function showBallDmg() {
        resetAll();
        tutBall.baseHp = 100;
        ballDmg.opacity = 1;
        tutBall.opacity = 1;
        tutBall.anchors.centerIn = tutorialScene;
        power = 10;
        hitDelayCount = 9;
    }

    function showMultiHit() {
        resetAll();
        tutBall.baseHp = 100;
        tutBall2.baseHp = 100;
        tutBall3.baseHp = 100;
        multiHit.opacity = 1;
        tutBall.opacity = 1;
        tutBall2.opacity = 1;
        tutBall3.opacity = 1;
        tutBall3.anchors.left = tutBall.horizontalCenter;
        tutBall3.anchors.verticalCenter = tutorialScene.verticalCenter;
        tutBall2.anchors.verticalCenter = tutorialScene.verticalCenter
        tutBall2.anchors.right = tutBall3.left;
        tutBall.anchors.centerIn = undefined;
        tutBall.anchors.verticalCenter = tutBall2.top
        power = 10;
        hitDelayCount = 9;
    }

    function showBallHeal() {
        resetAll();
        ballHeal.opacity = 1;
        tutBall.opacity = 1;
        tutBall.anchors.centerIn = undefined;
        tutBall.anchors.verticalCenter = undefined;
        tutBall.anchors.top = tutorialScene.gameWindowAnchorItem.top;
        tutBall.anchors.topMargin = 15
        tutBall.anchors.horizontalCenter = tutorialScene.horizontalCenter;
        healDelayCount = 9;
    }

    function showKeepMiddle() {
        resetAll();
        keepMiddle.opacity = 1;
        tutBall.opacity = 1;
        tutBall.anchors.top = undefined;
        tutBall.anchors.horizontalCenter = undefined;
        tutBall.anchors.centerIn = tutorialScene;
        power = 10;
        hitDelayCount = 9;
    }

    function showBallPopped() {
        resetAll();
        ballPopped.opacity = 1;
        floatingText.opacity = 1;
    }

    function showNewLevel() {
        resetAll();
        levelText.opacity = 1;
        newLevel.opacity = 1;
    }

    function showBallInfo() {
        resetAll();
        ballInfo.opacity = 1;
    }

    function showUniqueBalls(a) {
        resetAll();
        uniqueBalls.opacity = 1;
        if(a) {
            ballList1.opacity = 1;
        } else {
            ballList2.opacity = 2;
        }
    }

    function showGameOver() {
        resetAll();
        gameOver.opacity = 1;
        gameOverText.opacity = 1;
    }

    function showEnd() {
        resetAll();
        end.opacity = 1;
        moveButtonsTop();
    }

    function resetAll() {
        intro.opacity = 0;
        hud.opacity = 0;
        playerStatus.opacity = 0;
        pauseTut.opacity = 0;
        ballSpawn.opacity = 0;
        ballBounce.opacity = 0;
        ballDmg.opacity = 0;
        ballHeal.opacity = 0;
        keepMiddle.opacity = 0;
        multiHit.opacity = 0;
        ballPopped.opacity = 0;
        newLevel.opacity = 0;
        floatingText.opacity = 0;
        levelText.opacity = 0;
        gameOverText.opacity = 0;
        gameOver.opacity = 0;
        end.opacity = 0;
        uniqueBalls.opacity = 0;
        ballList1.opacity = 0;
        ballList2.opacity = 0;
        tutBall.opacity = 0;
        tutBall2.opacity = 0;
        tutBall3.opacity = 0;
        hitDelayCount = 0;
        healDelayCount = 0;
    }
}
