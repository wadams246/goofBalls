import VPlay 2.0
import QtQuick 2.0
import '../common'
import '../entities/Balls'

Item {
    id: ballInfo

    property alias pic: tutBall.ballPic
    property alias text: infoText.tutText

    width: infoText.width
    height: tutBall.height

    TutorialBall {
        id: tutBall
        ballPic: "greenBall"
    }

    Tutorial {
        id: infoText
        anchors.left: tutBall.right
        anchors.verticalCenter: tutBall.verticalCenter

        tutText: "Sample Text"
    }
}
