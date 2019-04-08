import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12
import "components"

Rectangle {
    id: mainRectangle

    property int fraction: mainRectangle.height / 20
    property alias rootWidth: mainRectangle.width
    property alias rootHeight: mainRectangle.height

    StackView {
        id: stack
        initialItem: mainComponent
        anchors.fill: parent
    }
    Component {
        id: mainComponent
        Rectangle {
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
                    onClicked: stack.push(aboutTitleContainer)
                }
            }
        }
    }

    Component {
        id: trainingPoppable
        BackContainer {
            title: ""
            content: Rectangle {
                color: "red"
                Text {
                    text: "dynamic comonent"
                }
            }
        }
    }

    Component {
        id: vocabulariesTitleContainer
        BackContainer {
            title: "МОИ СЛОВАРИ"
            content: Vocabularies {}
        }
    }

    Component {
        id: aboutTitleContainer
        BackContainer {
            title: "О ПРОГРАММЕ"
            content: About {}
        }
    }

    Component {
        id: training001CloseContainer
        BackContainer {
            content: Training001 {}
        }
    }
}

