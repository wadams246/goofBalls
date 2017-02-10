# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here


#RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

QT += widgets
QT += gui

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    qml/config.json \
    android/res/values/strings.xml \
    android/res/drawable-hdpi/ic_launcher.png \
    android/res/drawable-mdpi/ic_launcher.png \
    android/res/drawable-xhdpi/ic_launcher.png \
    android/res/drawable-xxhdpi/ic_launcher.png \
    assets/img/vplay-logo.png \
    ios/Def-568h@2x.png \
    ios/Def-667h@2x.png \
    ios/Def-Portrait-736h@3x.png \
    ios/Def-Portrait.png \
    ios/Def-Portrait@2x.png \
    ios/Def.png \
    ios/Def@2x.png \
    ios/Icon-60.png \
    ios/Icon-60@2x.png \
    ios/Icon-60@3x.png \
    ios/Icon-72.png \
    ios/Icon-72@2x.png \
    ios/Icon-76.png \
    ios/Icon-76@2x.png \
    ios/Icon-Small-40.png \
    ios/Icon-Small-40@2x.png \
    ios/Icon-Small-50.png \
    ios/Icon-Small-50@2x.png \
    ios/Icon.png \
    ios/Icon@2x.png \
    win/app_icon.ico \
    android/build.gradle \
    win/app_icon.rc \
    qml/common/MenuButton.qml \
    qml/common/SceneBase.qml \
    qml/scenes/ConfirmScene.qml \
    qml/scenes/CreditsScene.qml \
    qml/scenes/GameScene.qml \
    qml/scenes/MenuScene.qml \
    qml/scenes/OptionsScene.qml \
    qml/scenes/ScoresScene.qml \
    qml/scenes/SubMenuScene.qml \
    qml/Main.qml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/common/Ball.qml \
    qml/common/Bar.qml \
    qml/common/LevelBase.qml \
    qml/entities/Balls/BigBall.qml \
    qml/entities/Balls/BlueBall.qml \
    qml/entities/Balls/GreenBall.qml \
    qml/entities/Balls/HealBall.qml \
    qml/entities/Balls/HealerBall.qml \
    qml/entities/Balls/RedBall.qml \
    qml/entities/Balls/ShieldBall.qml \
    qml/entities/Balls/ShielderBall.qml \
    qml/entities/Balls/SpeedBall.qml \
    qml/entities/Balls/SplitBall.qml \
    qml/entities/Balls/SplitBall2.qml \
    qml/entities/Balls/SplitBall3.qml \
    qml/entities/Balls/SplitBuffBall.qml \
    qml/entities/Balls/SplitHealBall.qml \
    qml/entities/Balls/SplitHealerBall.qml \
    qml/entities/Balls/SplitShieldBall.qml \
    qml/entities/Balls/SplitShielderBall.qml \
    qml/entities/BallCollector.qml \
    qml/entities/BallGenerator.qml \
    qml/entities/CoolDownBar.qml \
    qml/entities/Ceiling.qml \
    qml/entities/FloatingPowerUpText.qml \
    qml/entities/FloatingText.qml \
    qml/entities/HealBolt.qml \
    qml/entities/HealBolt2.qml \
    qml/entities/HealthBar.qml \
    qml/entities/HealthText.qml \
    qml/entities/Player.qml \
    qml/entities/PowerUp.qml \
    qml/entities/ShieldBolt.qml \
    qml/entities/Wall.qml \
    qml/hud/HpBar.qml \
    qml/hud/Hud.qml \
    qml/hud/StatsBar.qml \
    qml/hud/XpBar.qml \
    qml/scenes/GameOverScene.qml

