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
            anchors.centerIn: parent
            text: "MОИ СЛОВАРИ"
        }
    }
}
