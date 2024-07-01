#ifndef API_H
#define API_H

#include <QNetworkAccessManager>
#include <QObject>

class Api : public QObject {
    Q_OBJECT
    QNetworkAccessManager* nm;
    QString token;

public:
    explicit Api(QObject* parent = nullptr);

public slots:
    void login(QString username, QString password);
    void signup(QString name, QString username, QString password);
    void tokenLogin(QString token);
    void test();
    void exitPrepare();

signals:
    void loginResponse(bool success, QString message);
    void signupResponse(bool success, QString message);
    void exitPrepared();
};

#endif // API_H
