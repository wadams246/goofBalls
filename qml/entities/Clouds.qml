import VPlay 2.0
import QtQuick 2.0

Item {

    id: clouds

    CloudSmall {
        xPos: menuScene.width * .15
    }
    CloudSmall {
        xPos: menuScene.width * .5
    }
    CloudSmall {
        xPos: menuScene.width
    }
    CloudSmall {
        xPos: menuScene.width * 1.5
    }
    CloudBig {
        xPos: menuScene.width * .30
    }
    CloudBig {
        xPos: menuScene.width * .70
    }
    CloudBig {
        xPos: menuScene.width * 1.15
    }
}
