import QtQuick 2.0
import QtQuick.Controls 2.0


Component {
    Rectangle {
        anchors.fill: parent
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
    }}

