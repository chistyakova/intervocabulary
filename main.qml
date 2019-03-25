import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12
import "components"

Rectangle {
    id: mainRectangle

    // Задание ширины и высоты окна.
    // Только для Desktop, на телефоне не применяется.
    width: Screen.desktopAvailableWidth / 4
    height: Screen.desktopAvailableHeight / 2

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
                anchors.centerIn: parent
                width: parent.width
                spacing: 5
                padding : 5
                Button {
                    width: parent.width
                    font.pixelSize: fraction * 2
                    text: "ТРЕНИРОВКА"
                    onClicked: stack.push(training001CloseContainer)
                }
                Button {
                    width: parent.width
                    text: "МОИ СЛОВАРИ"
                    font.pixelSize: fraction * 2
                    onClicked: stack.push(vocabulariesTitleContainer)
                }
                Button {
                    width: parent.width
                    text: "О ПРОГРАММЕ"
                    font.pixelSize: fraction * 2
                    onClicked: stack.push(aboutTitleContainer)
                }
            }
        }
    }

    Component {
        id: trainingPoppable
        TitleContainer {
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
        TitleContainer {
            title: "МОИ СЛОВАРИ"
            content: Vocabularies {}
        }
    }

    Component {
        id: aboutTitleContainer
        TitleContainer {
            title: "О ПРОГРАММЕ"
            content: About {}
        }
    }

    Component {
        id: training001CloseContainer
        CloseContainer {
            content: Training001 {}
        }
    }
}

