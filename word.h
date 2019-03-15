#ifndef WORD_H
#define WORD_H

#include <QObject>

class Word : public QObject
{
    Q_OBJECT
public:
    explicit Word(QObject *parent = nullptr);

signals:

public slots:
};

#endif // WORD_H