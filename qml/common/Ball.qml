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
    property int startBounce: -280
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
    property int startY: gameScene.height - 55
    property real shieldWidth: width * shieldIndicator
    property real shieldHeight: height * shieldIndicator
    property real gScale: 1
    property real lScale: 1
    property bool shielded: true
    property string ballPic: "greenBall"

//    BoxCollider {
//        id: collider
//        gravityScale: gScale
//        linearDamping: lScale
//        categories: Box.Category1
//        collidesWith: Box.Category2 | Box.Category3
//        fixture.restitution: 1
//    }


    CircleCollider {
        id: collider
        radius: spriteWidth / 2
        gravityScale: gScale
        linearDamping: lScale
        categories: cat
        collidesWith: Box.Category2 | Box.Category3
        fixture.restitution: 1
    }

    Rectangle {
        id: shieldIndicator
        height: ball.width + (shieldIndSize * (shieldHp / shieldMax))
        width: ball.height + (shieldIndSize * (shieldHp / shieldMax))
        radius: width / 2
        anchors.verticalCenter: sprite.verticalCenter
        anchors.horizontalCenter: sprite.horizontalCenter
        color: "#4CB0FF"
        opacity: 0
    }

    MultiResolutionImage {
        id: sprite
        width: spriteWidth
        height: spriteHeight
        source: "../../assets/img/" + ballPic + ".png"
    }

    MouseArea {
        id: mouse
        anchors.verticalCenter: sprite.verticalCenter
        anchors.horizontalCenter: sprite.horizontalCenter
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

    Rectangle {
        id: hpBarBack
        anchors.bottom: parent.top
        anchors.bottomMargin: 5
        height: 5
        width: spriteWidth
        color: "red"
        opacity: 0
        radius: 1

        Loader {
            id: hpBarBackLoader
            onLoaded: {fadeHpBack.stop()}
        }
        NumberAnimation on opacity {
            id: fadeHpBack
            to: 0
            duration: 2500
        }
    }

    Rectangle {
        id: hpBar
        anchors.bottom: parent.top
        anchors.bottomMargin: 5
        height: 5
        width: spriteWidth * (hp / totalHp)
        color: "#08dc05"
        opacity: 0
        radius: 1

        Loader {
            id: hpBarLoader
            onLoaded: {fadeHp.stop()}
        }
        NumberAnimation on opacity {
            id: fadeHp
            to: 0
            duration: 2500
        }
    }

    Text {
        id: healText
        anchors {
            bottom: hpBarBack.top
            horizontalCenter: hpBarBack.horizontalCenter
        }
        text: "+" + healAmount + " HP"
        color: "#08dc05"
        font.pixelSize: 8
        opacity: 0

        Loader {
            id: fadeHealLoader
            onLoaded: {fadeHealText.stop()}
        }
        NumberAnimation on opacity {
            id: fadeHealText
            to: 0
            duration: 1500
        }
    }

    Text {
        id: shieldText
        anchors {
            bottom: hpBarBack.top
            horizontalCenter: hpBarBack.horizontalCenter
        }
        text: "+" + shieldAmount + " Shield"
        color: "#0099ff"
        font.pixelSize: 8
        opacity: 0

        Loader {
            id: fadeShieldLoader
            onLoaded: {fadeShieldText.stop()}
        }
        NumberAnimation on opacity {
            id: fadeShieldText
            to: 0
            duration: 1500
        }
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
                refreshFade();
                resetShield();
            }
            checkHp();
        } else {
            hp -= playerPower
            player.score += bouncePoints
            refreshFade()
            checkHp()
        }

    }

    function moveBall() {
        collider.body.linearVelocity = Qt.point(0,0)
        var localForwardVector = collider.body.toWorldVector(Qt.point((mouse.mouseX - 25) * leftRight, tapBounce));
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
//                ballGen.adjustPercentages();
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

    function refreshFade() {
        fadeHpBack.stop();
        fadeHp.stop();
        hpBar.opacity = hpBarBack.opacity = 1;
        fadeHpBack.start();
        fadeHp.start();
    }

    function reset() {
        collider.body.linearVelocity = Qt.point(0,0)
    }

    function heal(hp) {
        console.debug("HEAL CALLED!!")
        this.hp = (this.hp + hp) > totalHp ? totalHp : this.hp += hp;
        healAmount = hp;
        fadeHealText.stop();
        healText.opacity = 1;
        fadeHealText.start();
        refreshFade();
    }

    function shield(sp) {
        console.debug("SHIELD CALLED!!");
        shielded = true;
        shieldHp = shieldHp + sp > shieldMax ? shieldMax : shieldHp + sp;
        shieldIndicator.opacity = 0.5;
        shieldAmount = sp;
        fadeShieldText.stop();
        shieldText.opacity = 1;
        fadeShieldText.start();
    }

    function getCenterX() {
        return x + width / 2;
    }
    function getCenterY() {
        return y + height / 2;
    }
}
