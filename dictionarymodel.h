#ifndef DICTIONARYMODEL_H
#define DICTIONARYMODEL_H

#include <QAbstractListModel>

#include "word.h"

class DictionaryModel : public QAbstractListModel
{
  Q_OBJECT
public:
  DictionaryModel(QVector<Word> *, QObject *parent = 0);
  virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
  enum Roles {
    Native = Qt::UserRole + 1,
    Translation
  };
  virtual QHash<int, QByteArray> roleNames() const;
  virtual QVariant data(const QModelIndex &index, int role) const;
private:
  QVector<Word> *words_;
};

#endif // DICTIONARYMODEL_H
