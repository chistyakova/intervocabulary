#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QHash>
#include <QVector>
#include <QtSql>

#include "rawtable.h"
#include "rawitem.h"
#include "rawgroup.h"
#include "groupsmodel.h"
#include "tablemodel.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int tileSize READ getTileSize NOTIFY tileSizeChanged)
    Q_PROPERTY(int columns READ getColumns)
public:
    explicit Controller(QObject *parent = nullptr);
    Q_INVOKABLE void setScreenWidth(const int);
    Q_INVOKABLE QString getNextWord();
    Q_INVOKABLE void setMaxColumnCount(const int);
    Q_INVOKABLE void clickTab(const uint);
    Q_INVOKABLE void addGroup(QString, QString);
    TableModel *tableModel;
    GroupsModel *groupsModel;
    QStringList iconsModel;
    int getTileSize();
    int getColumns();
    void InitializeTables();
    void InitializeGroups();
    void InitializeSettings();
    void addSqlTable(const QString name, const QString icon);
    void addSqlColumn(uint tableNum);
    void addSqlRow(uint tableNum, QStringList values);
    QVector<QStringList> getSqlTable(uint tableNum);
    const QStringList getIcons();
    void getSettings();
private:
    QSqlDatabase db_;
    QHash<uint, RawGroup*> rawgroups_;
    QHash<uint, RawTable*> rawtables_;
    QVector<uint> rawgroup_order_; // Номера груп в порядке как они должны идти в приложении.
    uint max_column_count_; // Максимальное число столбцов (приходит из QML).
    // Если из базы данных мы читаем группы в порядеке следования: [1,2,5,4,3],
    // то в этой переменной то же самое с учётом разбивки из-за ширины экрана:
    // [1,1,2,5,5,5,4,3].
    QVector<QPair<uint, uint> > tabs_;

    QStringList settings_;//настройки таблицы из tables_ из sqlite
    QVector<QVector<QVector<QVariant> > > tables_;//заполняется таблицами из sqlite
    QString iconPath_;
    int screen_width_;
    int char_height_;
    int char_width_;
    int tile_size_;
    int columns_;
signals:
    void tileSizeChanged();
public slots:    
};

#endif // CONTROLLER_H
