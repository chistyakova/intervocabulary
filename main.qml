import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Rectangle {
    id: mainRectangle

    // Для Desktop:
    width: Screen.desktopAvailableWidth / 4
    height: Screen.desktopAvailableHeight / 2

    StackView {
        id: stack
        initialItem: mainComponent
        anchors.fill: parent

        Component {
            id: mainComponent
            Rectangle {
                color: "#00ffff"
                Column {
                    anchors.centerIn: parent
                    width: parent.width
                    Button {
                        width: parent.width
                        text: "ТРЕНИРОВКА"
                        onClicked: stack.push(trainingComponent)
                    }
                    Button {
                        width: parent.width
                        text: "МОИ СЛОВАРИ"
                    }
                    Button {
                        width: parent.width
                        text: "О ПРОГРАММЕ"
                    }
                }
            }
        }
        Component {
            id: trainingComponent
            Rectangle {
                color: "#ff00ff"
                Button {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    text: "< НАЗАД"
                    onClicked: stack.pop()
                }
                Text {
                    id: currentWord
                    text:  {
                        var word = controller.getNextWord()
                        word.native+"<br>"+word.transcribtion+"<br>"+word.translation
                    }
                    font.pointSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            currentWord.text = Math.random()
                        }
                    }
                }
            }
        }
    }
}
