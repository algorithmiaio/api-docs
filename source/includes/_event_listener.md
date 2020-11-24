# Event Listeners

## The event listener object

```json
{
  "sourceType": "Kafka",
  "sourceURI": "ec2-34-221-191-143.us-west-2.compute.amazonaws.com:9092",
  "algoName": "test-algorithm",
  "algoOwner": "algo-owner",
  "algoVersion": "1.0.0",
  "credentials": "{\"username\": \"SASL-username\",\"password\": \"SASL-password\", \"topic\": \"test-topic\", \"certificate\": \"-----BEGIN CERTIFICATE-----\\r\\nMIIDuTCCAqGgAwIBAgIJALFQWXZx8OQuMA0GCSqGSIb3DQEBCwUAMHMxHzAdBgNV\\r\\nBAMMFmNhMS50ZXN0Lmh1c3NlaW5qb2UuaW8xDDAKBgNVBAsMA0RldjETMBEGA1UE\\r\\nCgwKSHVzc2VpbkpvZTESMBAGA1UEBwwJTWVsYm91cm5lMQwwCgYDVQQIDANWSUMx\\r\\nCzAJBgNVBAYTAkFVMB4XDTIwMTEyMzE4NTY0OVoXDTIxMTEyMzE4NTY0OVowczEf\\r\\nMB0GA1UEAwwWY2ExLnRlc3QuaHVzc2VpbmpvZS5pbzEMMAoGA1UECwwDRGV2MRMw\\r\\nEQYDVQQKDApIdXNzZWluSm9lMRIwEAYDVQQHDAlNZWxib3VybmUxDDAKBgNVBAgM\\r\\nA1ZJQzELMAkGA1UEBhMCQVUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB\\r\\nAQCeDV19eR+ZavTQCRVAnK\\/LAq80WPORYScLZWIPXwHl4QnIqbc7N7Lgt4rYPN20\\r\\njGEnu+FeblahCBPHer36ebKQLv0i4uJiuJwsiIZs1Bijy0td6JeetlHRPC7eUXrH\\r\\ngwOimbeQikXRc5xa2wrsr3DSLcrHGOvy6m+P+1NJu0qx6y\\/FlaOR0veFbko+SqL0\\r\\n7bxtn1ws8mRfgBj7ykKkm\\/GISuDVhrUV6KXGVZ6wNy5emlLTWr20iG+So+TzFCU2\\r\\nmZh7YJ7VV0g6R1xRIG3x0dlGd2St\\/feYpCDesoek56gWf6axZOHbOwiXX6JZRAUD\\r\\ngseUDv+pMf8GE5HwKkrRzV0tAgMBAAGjUDBOMB0GA1UdDgQWBBQiHrM5EwPei3SW\\r\\nhJE8uQUc2J7HNjAfBgNVHSMEGDAWgBQiHrM5EwPei3SWhJE8uQUc2J7HNjAMBgNV\\r\\nHRMEBTADAQH\\/MA0GCSqGSIb3DQEBCwUAA4IBAQBsdDqaHp\\/XnL6C33Yfs1+RA0h1\\r\\nupHAqx4Zd\\/KJctiSAshOfqzANP1tItIj8QXeuBCxuSzUdgzkQVho3Q2ryZHXd80Q\\r\\nnHQFJZ1kxLBblQgjv4oz2CaFM4NbJ0L0eKcbv+OhIp4CH+0w+GjSWNNsTd9pknQ1\\r\\nT1CqGt0GYBD0cZA8+OwaHfw\\/kHm81onn7JLHeMxDb4bP7ATUZ9EPtJD7FNiGDsZY\\r\\nvYEVbEOctPW5bnAksXWpFG\\/v\\/jtOsEXrgoz4GMzrYdLlOPhy06rekDUxwJebCzor\\r\\nAmBJ4EihAQ4Kjc1wNxCMx4VpSCtPjfsLp0WppqObDjPmgI+gUHVLrS0yTBXw\\r\\n-----END CERTIFICATE-----\"}"
}


    sourceType: String,
    sourceURI: String,
    algoName: String,
    algoOwner: String,
    algoVersion: Option[String],
    credentials: String

```

|Attribute|Type|Description|
|-|-|-|
|`sourceType`|String|Event listener type. Valid values are `AmazonSQS`, `AzureSB` and `Kafka`|
|`sourceURI`|String|Endpoint URI|
|`algoName`|String|The algorithm to which the event listener will provide data|
|`algoOwner`|String|The algorithm owner|
|`algoVersion`|String|The algorithm version (optional)|
|`credentials`|String|The credentials for the event listener. In case of Kafka, this is an embedded JSON object (see below). The entire json object must be escaped before it is assigned to this field so that it serializes as a JSON string properly |


## The Kafka Credentials object

```json
{
    "username": "SASL-username",
    "password": "SASL-password",
    "topic": "kafka-topic-name",
    "certificate": "CA-cert-content"
}
```

|Attribute|Type|Description|
|-|-|-|
|`username`|String|Kafka username |
|`password`|String|Kafka password|
|`topic`|String|The name of the topic to subscribe|
|`credentials`|String|The content of the CA certificate file. It's VERY important to serialize whitespace properly - the backend does not parse the certificate properly if whitespace is stripped from the content. 


## Create an event listener

```shell
curl https://api.algorithmia.com/v1/users/me/event-listeners \
  -X POST \
  -H 'Authorization: Simple ADMIN_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
"id": "test-topic",
"sourceType": "Kafka",
"sourceURI": "ec2-34-221-191-143.us-west-2.compute.amazonaws.com:9092",
"algoName": "test-algorithm",
"algoOwner": "algo-owner",
"algoVersion": "1.0.0",
"listenerOwner": "owner",
"credentials": "{\"username\": \"SASL-username\",\"password\": \"SASL-password\", \"topic\": \"test-topic\", \"certificate\": \"-----BEGIN CERTIFICATE-----\\r\\nMIIDuTCCAqGgAwIBAgIJALFQWXZx8OQuMA0GCSqGSIb3DQEBCwUAMHMxHzAdBgNV\\r\\nBAMMFmNhMS50ZXN0Lmh1c3NlaW5qb2UuaW8xDDAKBgNVBAsMA0RldjETMBEGA1UE\\r\\nCgwKSHVzc2VpbkpvZTESMBAGA1UEBwwJTWVsYm91cm5lMQwwCgYDVQQIDANWSUMx\\r\\nCzAJBgNVBAYTAkFVMB4XDTIwMTEyMzE4NTY0OVoXDTIxMTEyMzE4NTY0OVowczEf\\r\\nMB0GA1UEAwwWY2ExLnRlc3QuaHVzc2VpbmpvZS5pbzEMMAoGA1UECwwDRGV2MRMw\\r\\nEQYDVQQKDApIdXNzZWluSm9lMRIwEAYDVQQHDAlNZWxib3VybmUxDDAKBgNVBAgM\\r\\nA1ZJQzELMAkGA1UEBhMCQVUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB\\r\\nAQCeDV19eR+ZavTQCRVAnK\\/LAq80WPORYScLZWIPXwHl4QnIqbc7N7Lgt4rYPN20\\r\\njGEnu+FeblahCBPHer36ebKQLv0i4uJiuJwsiIZs1Bijy0td6JeetlHRPC7eUXrH\\r\\ngwOimbeQikXRc5xa2wrsr3DSLcrHGOvy6m+P+1NJu0qx6y\\/FlaOR0veFbko+SqL0\\r\\n7bxtn1ws8mRfgBj7ykKkm\\/GISuDVhrUV6KXGVZ6wNy5emlLTWr20iG+So+TzFCU2\\r\\nmZh7YJ7VV0g6R1xRIG3x0dlGd2St\\/feYpCDesoek56gWf6axZOHbOwiXX6JZRAUD\\r\\ngseUDv+pMf8GE5HwKkrRzV0tAgMBAAGjUDBOMB0GA1UdDgQWBBQiHrM5EwPei3SW\\r\\nhJE8uQUc2J7HNjAfBgNVHSMEGDAWgBQiHrM5EwPei3SWhJE8uQUc2J7HNjAMBgNV\\r\\nHRMEBTADAQH\\/MA0GCSqGSIb3DQEBCwUAA4IBAQBsdDqaHp\\/XnL6C33Yfs1+RA0h1\\r\\nupHAqx4Zd\\/KJctiSAshOfqzANP1tItIj8QXeuBCxuSzUdgzkQVho3Q2ryZHXd80Q\\r\\nnHQFJZ1kxLBblQgjv4oz2CaFM4NbJ0L0eKcbv+OhIp4CH+0w+GjSWNNsTd9pknQ1\\r\\nT1CqGt0GYBD0cZA8+OwaHfw\\/kHm81onn7JLHeMxDb4bP7ATUZ9EPtJD7FNiGDsZY\\r\\nvYEVbEOctPW5bnAksXWpFG\\/v\\/jtOsEXrgoz4GMzrYdLlOPhy06rekDUxwJebCzor\\r\\nAmBJ4EihAQ4Kjc1wNxCMx4VpSCtPjfsLp0WppqObDjPmgI+gUHVLrS0yTBXw\\r\\n-----END CERTIFICATE-----\"}"
}'
```
