import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Item {
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: vocabulariesList
            Layout.fillHeight: true
            Layout.fillWidth: true
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
                    height: 30
                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: "qrc:///svg/select.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                        }
                        Text {
                            Layout.fillWidth: true
                            text: title
                        }
                        Image {
                            source: "qrc:///svg/add.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    vocabulariesList.currentIndex = index
                                    stack.push(vocabularyPoppable)
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
                                    vocabulariesList.currentIndex = index
                                    stack.push(vocabularyCancellable)
                                }
                            }
                        }
                    }
                }
            }
        }
        Button {
            text: "Добавить словарь"
            onClicked: stack.push(vocabularyCancellable)
        }
    }
    Component {
        id: vocabularyPoppable
        Backable {
            title: vocabulariesModel.get(vocabulariesList.currentIndex).title
            content: Vocabulary {}
        }
    }
    Component {
        id: vocabularyCancellable
        Cancellable {
            content: Vocabulary {
                flag: "пока нет"
                title: vocabulariesList.currentIndex
                describtion: "пока нет"
            }
        }
    }
}
