import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "components"

ApplicationWindow {
    id: root
    property int fraction: mainRectangle.height / 20
    property alias rootWidth: mainRectangle.width
    property alias rootHeight: mainRectangle.height

    property color mainBackground: 'white'

    height: 500
    width:  300
    visible: true

    Rectangle {
        id: mainRectangle
        anchors.fill: parent


        StackView {
            id: stack
            initialItem: mainComponent
            anchors.fill: parent
        }
    }

    Component {
        id: mainComponent
        Rectangle {
            color: root.mainBackground
            Column {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 5
                anchors.margins: 5
                Button {
                    width: parent.width
                    font.pixelSize: fraction
                    text: "ТРЕНИРОВКА"
                    onClicked: {
                        controller.getWords()
                        stack.push(training001CloseContainer)
                    }
                }
                Button {
                    width: parent.width
                    text: "МОИ СЛОВАРИ"
                    font.pixelSize: fraction
                    onClicked: stack.push(vocabulariesTitleContainer)
                }
                Button {
                    width: parent.width
                    text: "О ПРОГРАММЕ"
                    font.pixelSize: fraction
                    onClicked: aboutDialog.open()//stack.push(aboutTitleContainer)
                }
            }
        }
    }

    Component {
        id: vocabulariesTitleContainer
        SlideContainer {
            content: Vocabularies {}
        }
    }

    Component {
        id: aboutTitleContainer
        SlideContainer {
            content: About {}
        }
    }

    Component {
        id: training001CloseContainer
        SlideContainer {
            content: Training001 {}
        }
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (root.width - width) / 2
        y: root.height / 6
        width: Math.min(root.width, root.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "The Qt Quick Controls 2 module delivers the next generation user interface controls based on Qt Quick."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "In comparison to the desktop-oriented Qt Quick Controls 1, Qt Quick Controls 2 "
                      + "are an order of magnitude simpler, lighter and faster, and are primarily targeted "
                      + "towards embedded and mobile platforms."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
