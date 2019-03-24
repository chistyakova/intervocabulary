import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property string title
    property Component content
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        RowLayout {
            z: 1
            width: parent.width
            spacing: 0
            Button {
                id: backButton
                text: ">"
                onClicked: stack.pop()
            }
            Rectangle {
                Layout.fillWidth: true
                height: backButton.height
                color: "lightblue"
                Text {
                    anchors.centerIn: parent
                    color: "blue"
                    text: parent.parent.parent.parent.title
                }
            }
            Image {
                source: "qrc:///svg/delete.svg"
                sourceSize.width: 24
                sourceSize.height: 24
            }
        }
        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: parent.parent.content
        }
    }

}
