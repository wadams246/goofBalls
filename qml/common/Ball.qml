import VPlay 2.0
import QtQuick 2.0
import "../scenes"
import "../entities"

EntityBase {
    id: ball
    entityType: "ball"

    width: 55
    height: 55
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
    property int spriteWidth: 55
    property int spriteHeight: 55
    property int healAmount: 0
    property int shieldAmount: 0
    property int shieldIndSize: 25
    property int shieldHp: 0
    property int shieldMax: 50 + Math.ceil((player.level / 25) * 50)
    property int cat: Circle.Category1
    property int startLeftRight: utils.generateRandomValueBetween(-200, 200)
    property int startX: utils.generateRandomValueBetween(55, gameScene.width-55)
    property int startY: gameScene.height + 50
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
        anchors.centerIn: sprite
        color: "#4CB0FF"
        opacity: 0
    }

    MultiResolutionImage {
        id: sprite
        source: "../../assets/img/" + ballPic + ".png"
        anchors.fill: collider
    }

    MouseArea {
        id: mouse
        anchors.centerIn: collider
        width: spriteWidth + 20
        height: spriteHeight + 45
        hoverEnabled: true
        onEntered: {
            bounce(player.power);
        }
        onPressed: {
            bounce(player.power)
        }
    }

    HealthBar {
        id: healthBar

        absoluteX: 0
        absoluteY: -healthBar.height * 2

        width: sprite.width
        height: 5

        percent: hp / totalHp

        visible: true
    }

    HealthText {
        id: healthText

        absoluteX: 0
        absoluteY: -20

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
        if(shielded) {
            shieldHp -= playerPower;
            if(shieldHp <= 0) {
                shielded = false;
                hp += shieldHp;
                player.score += bouncePoints;
                healthBar.resetBar();
                resetShield();
            }
            checkHp();
        } else {
            hp -= playerPower
            player.score += bouncePoints
            healthBar.resetBar();
            checkHp();
        }
    }

    function moveBall() {
        collider.body.linearVelocity = Qt.point(0,0)
        var forcePoint = collider.body.toWorldVector(Qt.point(5, 0))
        var force = collider.body.toWorldVector(Qt.point(1,1))
        var localForwardVector = Qt.point((mouse.mouseX - 25) * leftRight, tapBounce);
        collider.body.applyForce(force, forcePoint);
        collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
    }

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (ball.y / gameScene.height)
            player.score += killPoints
            calXp(xp)
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingText.qml"), {
                                                                "x": ball.x + (ball.width / 2),
                                                                "y": ball.y + ball.height,
                                                                "score": ball.killPoints,
                                                                "xp": ball.xp
                                                            });
            removeEntity()
        } else {
            moveBall()
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
        this.hp = (this.hp + hp) > totalHp ? totalHp : this.hp += hp;
        healthText.healAmount = healAmount = hp;
        shieldText.stopAnimation();
        healthText.fadeHealText();
        healthBar.resetBar();
    }

    function shield(sp) {
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
}
