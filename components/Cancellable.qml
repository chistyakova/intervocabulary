import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    property Component content
    property var save: function() {
        console.log("not overrid")
    }
    Rectangle {
        anchors.fill: parent
        color: "salmon"
        Button {
            text: "Сохранить"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            onClicked: {
                parent.parent.save()
            }
        }
        Button {
            text: "Отмена"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            onClicked: stack.pop()
        }
        Loader {
            id: contentCancellable
            anchors.fill: parent
            sourceComponent: parent.parent.content
        }
    }
}
