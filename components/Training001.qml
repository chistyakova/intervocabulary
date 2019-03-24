import QtQuick 2.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "cyan"
        Text {
            id: currentWord
            anchors.centerIn: parent
            text: controller.getNextWord().own
        }
        Image {
            source: "qrc:///svg/next.svg"
            sourceSize.width: 72
            sourceSize.height: 72
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentWord.text = controller.getNextWord().own
                }
            }
        }
    }
}
