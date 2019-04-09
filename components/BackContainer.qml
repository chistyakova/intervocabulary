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
                icon.source: "qrc:/svg/back.svg"
                icon.width: fraction * 2
                icon.height: fraction * 2
                onClicked: stack.pop()
            }
            Rectangle {
                Layout.fillWidth: true
                height: backButton.height

                color: "gainsboro"
                Text {
                    anchors.centerIn: parent
                    color: "blue"
                    font.pixelSize: fraction
                    text: parent.parent.parent.parent.title
                }
            }
        }
        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: parent.parent.content
        }
    }

}