import QtQuick 2.0

Item {
    property Component content
    Rectangle {
        anchors.fill: parent
        Image {
            anchors.top: parent.top
            anchors.left: parent.left
            source: "qrc:///svg/close.svg"
            sourceSize.width: fraction * 2
            sourceSize.height: fraction * 2
            z: 1
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stack.pop()
                }
            }
        }
        Loader {
            anchors.fill: parent
            sourceComponent: parent.parent.content
        }
    }
}
