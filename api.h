#ifndef API_H
#define API_H

#include <QObject>

class Api : public QObject {

    Q_OBJECT

public:

    explicit Api(QObject *parent = nullptr);

public slots:
    void authLogin(QString username, QString password);

signals:
    void authLoginResponse(bool success, QString message);
};

#endif // API_H
