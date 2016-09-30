import VPlay 2.0
import QtQuick 2.0
import "../"
import "../../scenes"
import "../../common"

HealBall {
    id: splitHealBall

    baseHp: 450
    baseXp: 750
    baseBouncePoints: 30
    baseKillPoints: 1250
    startBounce: -280
    tapBounce: -300
    baseDmgPoints: 25
    gScale: 1
    lScale: 1
    ballPic: "aquaBall"
    cat: Circle.Category1

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
            removeEntity()
            spawnTwo();
        } else {
            moveBall();
        }
    }

    function spawnTwo() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitHealerBall.qml"), {
                                                            "startLeftRight": -100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height
                                                        });
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitShielderBall.qml"), {
                                                            "startLeftRight": 100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height
                                                        });
    }
}
