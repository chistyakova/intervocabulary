#include <QDebug>
#include <QElapsedTimer>
#include <QDate>
#include <QTime>
#include <QtMath>
#include <QDateTime>
#include "controller.h"

#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
    max_column_count_ = 10000;

    InitializeSettings();
    InitializeGroups();
    InitializeTables();

    db_ = QSqlDatabase::addDatabase("QSQLITE");
    db_.setDatabaseName("tiary.sqlite");
    if (!db_.open())
        qDebug() << db_.lastError().text();
    QSqlQuery query("CREATE TABLE IF NOT EXISTS groups "
                    "(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, icon TEXT);");

    QDir dir(QCoreApplication::applicationDirPath() + "/icons");
    iconPath_ = "file:///" + dir.absolutePath() + "/";

    getSettings();

    groupsModel = new GroupsModel(&settings_);
    groupsModel->reset();
    tableModel = new TableModel(&settings_, &tables_);

    for(auto icon : getIcons()) {
        iconsModel.push_back(iconPath_ + icon);
    }
}

void Controller::InitializeTables() {
//    for (int i = 0; i < 7; ++i) { // 7 групп
//        for (int j = 0; j < 5; ++j) { // 5 таблиц в группе, всего 35 таблиц
//            uint table_id = static_cast<uint>(i*5+j); // номера по порядку 0-49
//            RawTable* rt = new RawTable();
//            QDateTime dateTime(QDate(17,10,26), QTime(0,0));
//            for (int k = 0; k < 1000; ++k) { // 10 000 значение в таблице
//                RawItem* ri = new RawItem(QVariant(table_id));
//                dateTime = dateTime.addSecs(60*60);
//                QString timestamp = dateTime.toString("yyMMddhhmm");
//                rt->InsertRawItem(timestamp.toInt(),ri);
//            }
//            rawtables_.insert(table_id,rt);
//        }
//    }
}

void Controller::InitializeGroups() {
    // Описание групп берём из qsettings, пока генерим вручную
    // [group1]
    // name=
    // descripton=
    // image=
    // scale=
    // table-order=
    //RawGroup *rg1 = new RawGroup();rg1->SetImage("food.svg");
    //RawGroup *rg2 = new RawGroup();rg2->SetImage("car.svg");
    //RawGroup *rg3 = new RawGroup();rg3->SetImage("glass.svg");
    //RawGroup *rg4 = new RawGroup();rg4->SetImage("hamburguer.svg");

    // Базовые иконки отсюда:
    // https://www.flaticon.com/packs/essential-collection
    //RawGroup *rg5 = new RawGroup();rg5->SetImage("add.svg");
    //RawGroup *rg6 = new RawGroup();rg6->SetImage("settings.svg");
    //RawGroup *rg7 = new RawGroup();rg7->SetImage("help.svg");
    //*(rg1->GetTableOrder()) = {0,3,1,2,4};
    //*(rg2->GetTableOrder()) = {5,6,7,8,9};
    //*(rg3->GetTableOrder()) = {10,11,12,13,14};
    //*(rg4->GetTableOrder()) = {15,16,17,18,19};
    //*(rg5->GetTableOrder()) = {};
    //*(rg6->GetTableOrder()) = {};
    //*(rg7->GetTableOrder()) = {};
    //rawgroups_.insert(1, rg1);
    //rawgroups_.insert(2, rg2);
    //rawgroups_.insert(3, rg3);
    //rawgroups_.insert(4, rg4);

    //rawgroups_.insert(5, rg5);
    //rawgroups_.insert(6, rg6);
    //rawgroups_.insert(7, rg7);
}

void Controller::InitializeSettings() {
    // Порядок групп читается из qsettings, пока генерим просто вручную
    // [settings]
    // group-order=1,2,3,6,5,4,7,8
    //rawgroup_order_.append(1);
    //rawgroup_order_.append(2);
    //rawgroup_order_.append(3);
    //rawgroup_order_.append(4);
    rawgroup_order_.append(5);
    rawgroup_order_.append(6);
    rawgroup_order_.append(7);
}

void Controller::setScreenWidth(const int width) {
    screen_width_ = width;
}

QString Controller::getNextWord() {
    QStringList words = {
        "Hello/Goodbye<br>안녕하세요<br>An-nyeong-ha-se-yo.",
        "Nice to meet you<br>반갑습니다<br>Ban-gap-sum-ni-da.",
        "Thank you<br>감사합니다<br>Kam-sa-ham-ni-da.",
        "I'm sorry<br>죄송합니다/미안합니다<br>Chway-seong-ham-ni-da/Mi-an-ham-ni-da."};
    return words.at(rand()%(words.length()-1));
}

int Controller::getTileSize() {
    return tile_size_;
}

int Controller::getColumns() {
    return columns_;
}

void Controller::setMaxColumnCount(const int count) {
    return;
    max_column_count_ = count;
    // Минимум 2 колонки должны быть всегда, иначе нет смысла.
    if (max_column_count_ < 2) {
        max_column_count_ = 2;
    }
    tabs_.clear();
    for (int i = 0; i < rawgroup_order_.count(); ++i) { // Проходим по всем группам.
        uint group_id = rawgroup_order_.at(i);
        QHash<uint, RawGroup*>::iterator rawgroups_it =
                rawgroups_.find(group_id);
        Q_ASSERT(rawgroups_it != rawgroups_.end());
        RawGroup* group = rawgroups_it.value(); // Текущая группа.
        // Вычисляем, на сколько табов надо разбить группу.
        uint splits = qCeil(static_cast<qreal>(group->GetTableOrder()->count())
                            / static_cast<qreal>(max_column_count_ - 1));
        if (splits < 1) splits = 1;
        for (uint j = 0; j < splits; ++j) {
            tabs_.append(qMakePair(group_id, j));
        }
    } // tabs_ - наполнен!

    //groupsModel->Feed(tabs_, 0);
    clickTab(0);
}

void Controller::clickTab(const uint index) {

    uint selected_group_id = tabs_.at(index).first;
    uint split_number = tabs_.at(index).second;

    QVector<uint> merged_timestamps;
    QList<RawTable *> merged_rawtables;
    QHash<uint, RawGroup*>::iterator selected_group_it = rawgroups_.find(selected_group_id);
    Q_ASSERT(selected_group_it != rawgroups_.end());
    RawGroup* selected_group = selected_group_it.value();
    QVector<uint>* table_order = selected_group->GetTableOrder();
    for (uint i = 0; i < max_column_count_ - 1; ++i) {
        uint pos = i + split_number * (max_column_count_ - 1);
        if (pos >= table_order->size()) {
            break;
        }
        uint table_id = table_order->at(pos);
        QHash<uint, RawTable *>::iterator table_it = rawtables_.find(table_id);
        Q_ASSERT(table_it != rawtables_.end());
        RawTable* table = table_it.value();
        merged_rawtables.append(table);
        QHash<uint, RawItem *>* rawitems = table->GetRawItems();
        QHash<uint, RawItem *>::iterator rawitems_it;
        if (rawitems->size() > 0) {
            for (rawitems_it = rawitems->begin();
                 rawitems_it != rawitems->end(); ++rawitems_it) {
                merged_timestamps.append(rawitems_it.key());
            }
        }
    }
    std::sort(merged_timestamps.begin(), merged_timestamps.end());
    merged_timestamps.erase(std::unique(
                                   merged_timestamps.begin(),
                                   merged_timestamps.end()),
                               merged_timestamps.end());

    groupsModel->clickTab(index);
    //tableModel->Feed(merged_timestamps, merged_rawtables);
}

void Controller::addGroup(QString name, QString icon)
{
    icon.replace(iconPath_,QString(""));

    QSqlQuery q;
    q.exec("INSERT INTO groups (id, name, icon) VALUES "
           "(NULL,\""+name+"\",\""+icon+"\");");
    getSettings();
    groupsModel->reset(); // даём команду модели перерисовать себя в Qml
}

void Controller::addSqlTable(const QString name, const QString icon)
{
    QSqlQuery query;
    query.exec("SELECT COUNT(*) FROM settings;");
    query.first();
    int num = query.value(0).toInt();
    QString newTable = QString("CREATE TABLE table%1 "
                               "(timestamp TEXT PRIMARY KEY NOT NULL, "
                               "value0 INTEGER);").arg(num);
    query.exec(newTable);
    QString newTableSet = "(\"" + name + "\"" + ", " + "\"" + icon + "\"" + ");";
    query.exec("INSERT INTO settings (name, icon) VALUES " + newTableSet);
}

void Controller::addSqlColumn(uint tableNum)
{
    QSqlQuery query(QString("SELECT * FROM table%1").arg(tableNum));
    int columnNum = query.record().count();
    if(columnNum>1)
    {
        QString newColumn = QString("ALTER TABLE table%1 "
                                    "ADD COLUMN value%2 INTEGER;").arg(tableNum).arg(columnNum-1);
        query.exec(newColumn);
    }
    else
    {
        qDebug() << "Wrong column number";
    }
}

void Controller::addSqlRow(uint tableNum, QStringList values)
{
    QString paramStr = "(timestamp,";
    QString valueStr = "(\"" + values.at(0) + "\",";
    for(int i=1; i<values.size(); i++)
    {
        if(i!=values.size()-1)
        {
            valueStr += values.at(i) + ",";
            paramStr += QString("value%1,").arg(i-1);
        }
        else
        {
            valueStr += values.at(i) + ")";
            paramStr += QString("value%1)").arg(i-1);
        }
    }

    QString newRow = QString("INSERT INTO table%1 ").arg(tableNum) + paramStr +
                             " VALUES " + valueStr + ";";
    QSqlQuery query;
    query.exec(newRow);
}

QVector <QStringList> Controller::getSqlTable(uint tableNum)
{
    QSqlQuery query(QString("SELECT * FROM table%1").arg(tableNum));
    uint columnNum = query.record().count();
    QVector <QStringList> table;
    QStringList row;
    while(query.next())
    {
        row.clear();
        for(uint i=0; i<columnNum; i++)
        {
            row.push_back(query.value(i).toString());
        }
        table.push_back(row);
    }

    return table;
}

const QStringList Controller::getIcons()
{
    QDir dir(QCoreApplication::applicationDirPath() + "/icons");
    QFileInfoList list = dir.entryInfoList();
    QStringList iconList;
    for (int i = 0; i < list.size(); ++i) {
        QFileInfo fileInfo = list.at(i);
        if(fileInfo.suffix() == "svg")
        {
            iconList.push_back(fileInfo.fileName());
        }
    }
    return iconList;
}

void Controller::getSettings()
{
    QSqlQuery query("SELECT icon FROM groups");
    settings_.clear();
    while(query.next())
    {
        settings_.push_back(iconPath_ + query.value(0).toString());
    }
}
