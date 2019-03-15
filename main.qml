import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Rectangle {
    id: mainRectangle

    // Для Desktop:
    width: Screen.desktopAvailableWidth / 4
    height: Screen.desktopAvailableHeight / 2

    Component.onCompleted: {
        controller.setScreenWidth(Screen.desktopAvailableWidth)
    }
    onWidthChanged:{
        controller.setScreenWidth(mainRectangle.width)
    }

    StackView {
        id: stack
        initialItem: mainComponent
        anchors.fill: parent

        Component {
            id: mainComponent
            Rectangle {
                anchors.fill: parent
                color: "#00ffff"
                Text {
                    id: currentWord
                    text:  {
                        var word = controller.getNextWord()
                        word.native+"<br>"+word.transcribtion+"<br>"+word.translation
                    }
                    //text: controller.tileSize
                    font.pointSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Math.random()
                    }
                }
            }
        }
    }
}
