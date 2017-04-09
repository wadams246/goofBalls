import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: splitBall3

    baseHp: 125
    baseXp: 500
    baseBouncePoints: 35
    baseKillPoints: 1500
    startBounce: -280
    tapBounce: -300
    baseDmgPoints: 10
    gScale: 1
    lScale: 1
    ballPic: "pinkBall"

    property int splitDirection: 0

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (y / gameScene.height);
            player.score += killPoints;
            calXp(xp);
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../FloatingText.qml"), {
                                                                "x": x + (width / 2),
                                                                "y": y + height,
                                                                "score": killPoints,
                                                                "xp": xp
                                                            });
            audioManager.playSound("pop");
            removeEntity();
        } else {
            audioManager.playSound("bounce");
            moveBall();
        }
    }
}

