import VPlay 2.0
import QtQuick 2.0
import './Balls'
import '../entities'
import '../common'

Rectangle {
    id: list

    color: "transparent"

    width: children.width
    height: children.height

    BallInfo {
        id: healerInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: list.top
            topMargin: 10
        }
        pic: "whiteBall"
        text: "Average bounce, average fall,\n and ability to heal others."
    }

    BallInfo {
        id: shielderInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: healerInfo.bottom
        }

        pic: "darkGrayBall"
        text: "Average bounce, average fall,\n and ability to shield others."
    }

    BallInfo {
        id: splitInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: shielderInfo.bottom
        }

        pic: "pinkBall"
        text: "Average bounce, fast fall,\n and splits into 2 when popped."
    }

    BallInfo {
        id: splitBuffInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: splitInfo.bottom
        }

        pic: "clearBall"
        text: "Average bounce, very fast fall,\n high HP, and splits into\n 2 when popped."
    }

    BallInfo {
        id: bigBallInfo

        anchors {
            left: list.left
            leftMargin: 10
            top: splitBuffInfo.bottom
        }

        pic: "purpleBall"
        text: "Starts at the top of the screen and \n cannot not be bounced. Very very\n slow fall, and very very high HP."
    }
}
