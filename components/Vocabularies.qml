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
            // model: dictionariesModel
            model: ListModel {
                id: vocabulariesModel
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 1 курс"
                }
                ListElement {
                    language: "Korean"
                    title: "ККЦ 2 курс"
                }
                ListElement {
                    language: "English"
                    title: "Слова из сериала Офис"
                }
            }
            delegate: Component {
                Rectangle {
                    width: parent.width
                    height: 24
                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: "qrc:///svg/select.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            height: 24
                            Text {
                                anchors.centerIn: parent
                                text: title
                            }
                        }
                        Image {
                            source: "qrc:///svg/list.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    stack.push(wordsTitleContainer)
                                }
                            }
                        }
                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
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
                            sourceSize.width: 24
                            sourceSize.height: 24
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
            onClicked: {
                selected_vocabulary = -1
                stack.push(vocabularySaveCancelContainer)
            }
        }
    }
    Component {
        id: wordsTitleContainer
        TitleContainer {
            title: vocabulariesModel.get(selected_vocabulary).title
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
                describtion: ""
            }
        }
    }
}
