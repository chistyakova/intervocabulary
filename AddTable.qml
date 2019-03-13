import QtQuick 2.7

Rectangle {
    color: "#ffffff"
    Rectangle {
        id: addtabletitle
        anchors.top: parent.top
        width: parent.width
        height: controller.tileSize
        color: "#eeeeee"
        Text {
            anchors.centerIn: parent
            text: "Добавить новую таблицу"
            font.pixelSize: 22
        }
    }
    Rectangle {
        anchors.top: addtabletitle.bottom
        anchors.right: parent.right
        color: "#dddddd"
        height: controller.tileSize
        width: parent.width - controller.tileSize
        Text {
            anchors.centerIn: parent
            text: "Выбери иконку"
            font.pixelSize: 18
        }
        MouseArea {
            anchors.fill: parent
            onClicked: stack.push(chooseiconcomponent)
        }
    }
    Rectangle {
        anchors.top: addtabletitle.bottom
        anchors.left: parent.left
        height: controller.tileSize
        width: height
        color: "#cccccc"
        Image {
            id: addtableicon
           anchors.centerIn: parent
           width: parent.width / 1.5
           height: parent.height / 1.5
           source: newTableIcon
        }
    }
    /*TextInput {
        id: groupAddRectangleText
        anchors.top: groupAddRectangleHeading.bottom
        text: "Введите название таблицы"
        font.family: "Helvetica"
        font.pointSize: 20
        color: "blue"
        focus: true
    }*/
    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: controller.tileSize
        height: width
        color: "green"

        Text {
            anchors.centerIn: parent
            color: "yellow"
            text: "OK"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                controller.addGroup("tablename", addtableicon.source)
                stack.pop()
            }
        }
    }
    Rectangle {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: controller.tileSize
        height: width
        color: "red"

        Text {
            anchors.centerIn: parent
            color: "yellow"
            text: "<"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.pop()
            }
        }
    }
}
