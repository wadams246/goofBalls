import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import "../../scenes"
import "../../entities"
import "../../common"

EntityBase {
    id: ball
    entityType: "ball"

    width: 60
    height: 60


    property int baseHp: 50
    property int hp: baseHp + Math.ceil(baseHp * (player.level * .05))
    property int totalHp: baseHp + Math.ceil(baseHp * (player.level * .05))
    property int baseBouncePoints: 5
    property int bouncePoints: baseBouncePoints + Math.ceil(baseBouncePoints * (player.level * .1))
    property int baseKillPoints: 100
    property int killPoints: baseKillPoints + Math.ceil(baseKillPoints * (player.level * .1))
    property int baseXp: 100
    property int xp: baseXp + Math.ceil(baseXp * (player.level * .15))
    property int spriteWidth: width
    property int spriteHeight: height
    property int healAmount: 0
    property bool shielded: false
    property string ballPic: "greenBall"
    property alias healthBar: healthBar
    property int textX: 0
    property int textY: 0

//    Rectangle {
//        id: shieldIndicator

//        height: ball.width + (shieldIndSize * (shieldHp / shieldMax))
//        width: ball.height + (shieldIndSize * (shieldHp / shieldMax))
//        radius: width / 2
//        anchors.centerIn: spriteSequence
//        color: "#4CB0FF"
//        opacity: 0
//    }

    Highlights {
        id: highLights

        absoluteX: 0
        absoluteY: 0

        width: ball.width
        height: ball.height
        pic: ballPic
    }

    SpriteSequenceVPlay {
        id: spriteSequence

        anchors.centerIn: parent
        width: ball.width
        height: ball.height

        SpriteVPlay {
          name: "idle"
          frameCount: 1
          frameRate: 1

          frameWidth: 200
          frameHeight: 200
          source: "../../../assets/img/balls/" + ballPic + "Face.png"
          to: {"hit":0, "idle": 1}
        }

        SpriteVPlay {
          name: "hit"
          frameCount: 1
          frameRate: 1
          startFrameColumn: 2

          frameWidth: 200
          frameHeight: 200
          source: "../../../assets/img/balls/" + ballPic + "Face.png"
          to: {"idle":1}
        }
    }

    HealthBar {
        id: healthBar

        absoluteX: 0
        absoluteY: -healthBar.height * 2

        width: spriteSequence.width
        height: 5
        percent: hp / totalHp

        visible: true
    }

    HealthText {
        id: healthText

        absoluteX: 0
        absoluteY: 0

        width: ball.width
        height: 8

        healAmount: ball.healAmount
    }

//    ShieldText {
//        id: shieldText

//        absoluteX: 0
//        absoluteY: -20

//        width: ball.width
//        height: 8

//        shieldAmount: ball.shieldAmount
//    }

    function bounce(playerPower) {
        spriteSequence.jumpTo("hit")
        if(shielded) {
            shieldHp -= playerPower;
            if(shieldHp <= 0) {
                shielded = false;
                hp += shieldHp;
                player.score += bouncePoints;
                healthBar.resetBar();
//                resetShield();
            }
//            checkHp();
        } else {
            hp -= playerPower
            player.score += bouncePoints
            healthBar.resetBar();
//            checkHp();
        }
    }

    function heal(hp) {
        this.hp = (this.hp + hp) > totalHp ? totalHp : this.hp += hp;
        healthText.healAmount = healAmount = hp;
//        shieldText.stopAnimation();
        healthText.fadeHealText();
        healthBar.resetBar();
    }

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (ball.y / gameScene.height);
            player.score += killPoints;
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../FloatingText.qml"), {
                                                                "x": tutBall.x,
                                                                "y": tutBall.y,
                                                                "score": tutBall.killPoints,
                                                                "xp": tutBall.xp
                                                            });
            tutBall.opacity = 0;
        }
    }
}
