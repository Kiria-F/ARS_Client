#include "api.h"

#include <QDataStream>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QNetworkRequest>

#include "arsapirequest.h"
#include "arsapiurl.h"

Api::Api(QObject* parent)
    : QObject(parent)
    , nm(new QNetworkAccessManager(this)) {
    nm->connectToHost(ArsApiUrl::address);
}

void Api::login(QString username, QString password) {
    QNetworkReply* reply = nm->post(ArsApiRequest("login"),
                                    ArsApiRequest::toJsonBody(
                                        {{"username", username}, {"password", password}}));
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        auto response = reply->readAll();
        auto doc = QJsonDocument::fromJson(response);
        token = doc["token"].toString();
        emit loginResponse(!reply->error(), response);
        reply->deleteLater();
    });
}

void Api::tokenLogin(QString token) {
    QNetworkReply* reply = nm->post(ArsApiRequest("login"),
                                    ArsApiRequest::toJsonBody({{"token", token}}));
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        auto response = reply->readAll();
        emit loginResponse(!reply->error(), response);
        reply->deleteLater();
    });
}

void Api::signup(QString name, QString username, QString password) {
    QNetworkReply* reply = nm->post(ArsApiRequest("signup"),
                                    ArsApiRequest::toJsonBody({{"name", name},
                                                               {"username", username},
                                                               {"password", password}}));
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        auto response = reply->readAll();
        emit signupResponse(!reply->error(), response);
        reply->deleteLater();
    });
}

void Api::test() {}

void Api::exitPrepare() {
    QNetworkReply* reply = nm->post(ArsApiRequest("close-session"), ('"' % token % '"').toUtf8());
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error())
            qDebug() << "\n ERROR:\n" << reply->errorString();
        reply->deleteLater();
        qDebug() << "Session closed";
        emit exitPrepared();
    });
}
