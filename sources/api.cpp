#include "api.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QDataStream>
#include <QJsonObject>
#include <QJsonDocument>
#include "arsapiurl.h"

Api::Api(QObject *parent) : QObject(parent) {}

void Api::authLogin(QString username, QString password) {
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    QNetworkRequest request;
    request.setUrl(ArsApiUrl("login"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject bodyObject;
    bodyObject["username"] = username;
    bodyObject["password"] = password;
    QJsonDocument bodyDoc(bodyObject);

    QNetworkReply *reply = manager->post(request, bodyDoc.toJson());
    connect(reply, &QNetworkReply::finished, this, [this, reply](){
        auto error = reply->error();
        emit authLoginResponse(!error, QString::fromUtf8(reply->readAll()));
        reply->deleteLater();
    });
}

void Api::authRegister(QString name, QString username, QString password) {
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    QNetworkRequest request;
    request.setUrl(ArsApiUrl("register"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject bodyObject;
    bodyObject["name"] = username;
    bodyObject["username"] = username;
    bodyObject["password"] = password;
    QJsonDocument bodyDoc(bodyObject);

    QNetworkReply *reply = manager->post(request, bodyDoc.toJson());
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        auto error = reply->error();
        emit authRegisterResponse(!error, QString::fromUtf8(reply->readAll()));
        reply->deleteLater();
    });
}
