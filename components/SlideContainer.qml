import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property string title
    property Item content
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
            Loader {
                Layout.fillWidth: true
                height: backButton.height
                sourceComponent: content.header
            }
        }
        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: content.body
        }
    }

}
