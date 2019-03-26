#ifndef WORDSMODEL_H
#define WORDSMODEL_H

#include <QAbstractListModel>

#include "word.h"

class WordsModel : public QAbstractListModel
{
  Q_OBJECT
public:
  WordsModel(QVector<Word> *, QObject *parent = nullptr);
  virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
  enum Roles {
    native_word = Qt::UserRole + 1,
    foreign_word
  };
  virtual QHash<int, QByteArray> roleNames() const;
  virtual QVariant data(const QModelIndex &index, int role) const;

  void notifyChange();
private:
  QVector<Word> *words_;
};

#endif // WORDSMODEL_H
