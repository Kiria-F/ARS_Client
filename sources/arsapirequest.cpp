#include "arsapirequest.h"

#include <QJsonDocument>
#include <QJsonObject>

#include "arsapiurl.h"

ArsApiRequest::ArsApiRequest() {
    setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
}

ArsApiRequest::ArsApiRequest(QString action)
    : ArsApiRequest() {
    setUrl(ArsApiUrl(action));
}

QByteArray ArsApiRequest::toJsonBody(QMap<QString, QString> body) {
    QJsonObject obj;
    for (auto kvp = body.constKeyValueBegin(); kvp != body.constKeyValueEnd(); kvp++) {
        obj[kvp->first] = kvp->second;
    }
    return QJsonDocument(obj).toJson(QJsonDocument::Compact);
}
