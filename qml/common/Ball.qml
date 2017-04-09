import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import "../scenes"
import "../entities"
import "../common"

EntityBase {
    id: ball
    entityType: "ball"

    width: 60
    height: 60
    z: 1

    property int baseHp: 50
    property int hp: baseHp + Math.ceil(baseHp * (player.level * .05))
    property int totalHp: baseHp + Math.ceil(baseHp * (player.level * .05))
    property int baseBouncePoints: 5
    property int bouncePoints: baseBouncePoints + Math.ceil(baseBouncePoints * (player.level * .1))
    property int baseKillPoints: 100
    property int killPoints: baseKillPoints + Math.ceil(baseKillPoints * (player.level * .1))
    property int startBounce: -420
    property int tapBounce: -175
    property int leftRight: -4
    property int baseDmgPoints: 10
    property int dmgPoints: baseDmgPoints + Math.ceil(baseDmgPoints * (player.level * .05))
    property int baseXp: 100
    property int xp: baseXp + Math.ceil(baseXp * (player.level * .15))
    property int spriteWidth: width
    property int spriteHeight: height
    property int healAmount: 0
    property int shieldAmount: 0
    property int shieldIndSize: 25
    property int shieldHp: 0
    property int shieldMax: 50 + Math.ceil((player.level / 25) * 50)
    property int cat: Circle.Category1
    property int startX: utils.generateRandomValueBetween(width, gameScene.width - width)
    property int startY: gameScene.height + 50
    property int startRight: utils.generateRandomValueBetween(0, 200);
    property int startLeft: utils.generateRandomValueBetween(0, -200);
    property int startLeftRight: startX > gameScene.width / 2 ? startLeft : startRight;
    property int newRotation: 0
    property int rotationSpeed: 5000
    property real shieldWidth: width * shieldIndicator
    property real shieldHeight: height * shieldIndicator
    property real gScale: 1
    property real lScale: 1
    property bool shielded: true
    property string ballPic: "greenBall"
    property alias healthBar: healthBar

    CircleCollider {
        id: collider

        radius: spriteWidth / 2
        gravityScale: gScale
        linearDamping: lScale
        categories: cat
        fixture.density: 1/3025

        collidesWith: Box.Category2 | Box.Category3
        fixture.restitution: 1
    }

    Rectangle {
        id: shieldIndicator

        height: ball.width + (shieldIndSize * (shieldHp / shieldMax))
        width: ball.height + (shieldIndSize * (shieldHp / shieldMax))
        radius: width / 2
        anchors.centerIn: spriteSequence
        color: "#4CB0FF"
        opacity: 0
    }

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
          source: "../../assets/img/balls/" + ballPic + "Face.png"
          to: {"hit":0, "idle": 1}
        }

        SpriteVPlay {
          name: "hit"
          frameCount: 1
          frameRate: 1
          startFrameColumn: 2

          frameWidth: 200
          frameHeight: 200
          source: "../../assets/img/balls/" + ballPic + "Face.png"
          to: {"idle":1}
        }
    }

    MouseArea {
        id: mouse
        anchors.centerIn: collider
        width: parent.width + 20
        height: parent.height + 60
//        hoverEnabled: true
//        onEntered: {
//            bounce(player.power);
//        }
        onPressed: {
            bounce(player.power)
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

    ShieldText {
        id: shieldText

        absoluteX: 0
        absoluteY: -20

        width: ball.width
        height: 8

        shieldAmount: ball.shieldAmount
    }

    Component.onCompleted: {
        x = startX;
        y = startY;
        var localForwardVector = collider.body.toWorldVector(Qt.point(startLeftRight, startBounce));
        collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
    }

    function bounce(playerPower) {
        spriteSequence.jumpTo("hit")
        if(shielded) {
            shieldHp -= playerPower;
            if(shieldHp <= 0) {
                shielded = false;
                hp += shieldHp;
//                showDmg(shieldHp);
                player.score += bouncePoints;
                healthBar.resetBar();
                resetShield();
            }
            checkHp();
        } else {
            hp -= playerPower
//            showDmg(-playerPower);
            player.score += bouncePoints
            healthBar.resetBar();
            checkHp();
        }
    }

    function moveBall() {
        collider.body.linearVelocity = Qt.point(0,0);
        var forcePoint = collider.body.toWorldVector(Qt.point(5, 0));
        var force = collider.body.toWorldVector(Qt.point(1,1));
        var localForwardVector = Qt.point((mouse.mouseX - 25) * leftRight, tapBounce);
        collider.body.applyForce(force, forcePoint);
        collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
    }

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (ball.y / gameScene.height);
            player.score += killPoints;
            calXp(xp);
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingText.qml"), {
                                                                "x": collider.body.getWorldCenter().x - width * 0.5,
                                                                "y": collider.body.getWorldCenter().y - height * 0.5,
                                                                "score": ball.killPoints,
                                                                "xp": ball.xp
                                                            });
            audioManager.playSound("pop");
            removeEntity();
        } else {
            audioManager.playSound("bounce");
            moveBall();
        }
    }

    function calXp(xp) {
        player.xp += xp;
        if(player.xp >= player.toNextLevel) {
            player.increaseLevel();
            if(player.level > 4) {
                ballGen.increaseBBChance();
            }

            player.xp = player.xp - player.toNextLevel;
            player.toNextLevel *= 1.65;
            gameScene.changeInterval(player.level);
        }
    }

    function resetShield() {
        shieldIndicator.opacity = 0;
        shieldHp = 0;
    }

    function reset() {
        collider.body.linearVelocity = Qt.point(0,0)
    }

    function heal(hp) {
//        audioManager.playSound("heal");
        this.hp = (this.hp + hp) > totalHp ? totalHp : this.hp += hp;
        healthText.healAmount = healAmount = hp;
        shieldText.stopAnimation();
        healthText.fadeHealText();
        healthBar.resetBar();
    }

    function shield(sp) {
//        audioManager.playSound("shield");
        shielded = true;
        shieldHp = shieldHp + sp > shieldMax ? shieldMax : shieldHp + sp;
        shieldIndicator.opacity = 0.5;
        shieldAmount = sp;
        healthText.stopAnimation();
        shieldText.fadeShieldText(sp);
    }

    function getCenterX() {
        return ball.x + (ball.width / 2);
    }
    function getCenterY() {
        return ball.y + (ball.height / 2);
    }
    function showDmg(dmg) {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/DmgText.qml"), {
                                                            "x": collider.body.getWorldCenter().x - 10,
                                                            "y": collider.body.getWorldCenter().y - 10,
                                                            "dmg": dmg
                                                        });
    }
}
