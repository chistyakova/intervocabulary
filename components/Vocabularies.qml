import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Item {
    property int selected_vocabulary: 0
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: vocabulariesList
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: vocubsModel
            delegate: Component {
                Rectangle {
                    width: vocabulariesList.width
                    height: fraction * 2
                    color: index % 2 == 0 ? "#efefef" : "#f8f8f8" // чередуем цвет полосок в ListView
                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: flag ? "qrc:/svg/check.svg" : "qrc:/svg/uncheck.svg"
                            sourceSize.width: fraction
                            sourceSize.height: fraction
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    controller.setVocubFlag(
                                                vocubsModel.get(selected_vocabulary).title, !flag)
                                }
                            }
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            height: fraction
                            color: "transparent"
                            Text {
                                anchors.centerIn: parent
                                text: title
                                font.pixelSize: fraction
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    controller.getWords(
                                                vocubsModel.get(selected_vocabulary).title)
                                    stack.push(wordsTitleContainer)
                                }
                            }
                        }
                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: fraction
                            sourceSize.height: fraction
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    stack.push(vocabularySaveCancelContainer)
                                }
                            }
                        }
                        Image {
                            source: "qrc:///svg/delete.svg"
                            sourceSize.width: fraction
                            sourceSize.height: fraction
                            MouseArea {
                                anchors.fill: parent
                                onPressAndHold: {
                                    console.log("delete "+index)
                                }
                            }
                        }
                    }
                }
            }
        }
        Button {
            text: "Добавить словарь"
            font.pixelSize: fraction
            implicitWidth: parent.width // Button не имеет поля width, вместо него это!
            onClicked: {
                selected_vocabulary = -1
                stack.push(vocabularySaveCancelContainer)
            }
        }
    }
    Component {
        id: wordsTitleContainer
        TitleContainer {
            title: vocubsModel.get(selected_vocabulary).title
            content: Words {}
        }
    }
    Component {
        id: vocabularySaveCancelContainer
        SaveCancelContainer {
            content: Vocabulary {
                flag: ""
                title: {
                    if (selected_vocabulary > -1)
                        vocabulariesModel.get(selected_vocabulary).title
                    else
                        ""
                }
                description: ""
            }
        }
    }
}
