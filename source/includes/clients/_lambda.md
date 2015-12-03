## AWS Lambda

[needs review]
[needs formatting]

### What is Lambda?

[AWS Lambda](https://aws.amazon.com/lambda) is a compute service that runs your code in response to events and automatically manages the compute resources for you, making it easy to build applications that respond quickly to new information.

### Algorithmia + Lambda
Algorithmia provides a built-in AWS Lambda Node.js blueprint, making it easy to call the Algorithmia API in response to events from Amazon Kinesis, Amazon DynamoDB, Amazon S3, and other Amazon web services.

For example, you could combine several algorithms from Algorithmia to:

* Automatically generate smart thumbnails (using face detection to ensure every thumbnail is perfectly cropped)
* Take advantage of Algorithmia’s speech-to-text algorithm to transcribe videos uploaded to S3 on the fly
* You could even leverage a predictive model every time DynamoDB updates.

Algorithmia and Lambda make it easy to rapidly build and deploy serverless solutions in minutes.

### Setup your Lambda function

#### Getting started

* Navigate to the [AWS Lambda console](https://console.aws.amazon.com/lambda/home)
* Select `Create a Lambda function`
* Type `Algorithmia` into the filter
* Select the Algorithmia blueprint
* Setup Auth in your Lambda function using the below guide
* Specify your algorithm and input data

#### Authentication

##### Basic method

Basic method:

###### 1. Set apiKey to your Algorithmia API key
```javascript
//Lambda code:
apiKey = "@apiKey";
kmsEncryptedApiKey =  null;
```

##### Advanced method (more secure)
Follow these steps to encrypt your Algorithmia API Key for use in this function:

###### 1. Create a KMS key

Follow [this AWS guide](http://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html) to create your KMS key.

###### 2. Give your lAWS Lambda function execution role permission for the kms:Decrypt action
Example Role:
```json
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "Stmt1443036478000",
        "Effect": "Allow",
        "Action": [
            "kms:Decrypt"
        ],
        "Resource": [
            "<your KMS key ARN>"
        ]
    }
    ]
}
```

###### 3. Encrypt the event collector token using the AWS CLI
```bash
aws kms encrypt --key-id alias/<KMS key name> --plaintext "<ALGORITHMIA_API_KEY>"
```

###### 4. Copy the base-64 encoded, encrypted key (CiphertextBlob) to the kmsEncryptedApiKey variable
```javascript
//Lambda code:
kmsEncryptedApiKey = "<kmsEncryptedApiKey>";
```

### Examples:

#### Smart thumbnails:

@defining("../.." + routes.Algorithms.get("opencv", "SmartThumbnail")) { algoRoute =\>
Algorithm: [algo://opencv/SmartThumbnail](@algoRoute)
}

```javascript
/*
 * Lambda processEvent function:
 */
var processEvent = function(event, context) {

    // Specify the target algorithm
    var algorithm = "algo://opencv/SmartThumbnail";

    //Setup the input
    var s3 = new AWS.S3();
    var bucket = event.Records[0].s3.bucket.name;
    var key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "));
    var params = {Bucket: bucket, Key: key};
    var signedUrl = s3.getSignedUrl('getObject', params);
    var inputData = [signedUrl, 200, 50];

    // Run the algorithm
    var client = algorithmia(apiKey);
    client.algo(algorithm).pipe(inputData).then(function(output) {
        if(output.error) {
            // The algorithm returned an error
            console.log("Error: " + output.error.message);
            context.fail(output.error.message);
        } else {
            // Process the algorithm output
            context.succeed(output.result);
        }
    });
}
```

#### Transcribe video (speech to text):

@defining("../.." + routes.Algorithms.get("sphinx", "SpeechRecognition")) { algoRoute =\>
Algorithm: [algo://sphinx/SpeechRecognition](@algoRoute)
}

```javascript
/*
 * Lambda processEvent function:
 */
var processEvent = function(event, context) {

    // Specify the target algorithm
    var algorithm = "algo://sphinx/SpeechRecognition";

    //Setup the input
    var s3 = new AWS.S3();
    var bucket = event.Records[0].s3.bucket.name;
    var key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "));
    var params = {Bucket: bucket, Key: key};
    var signedUrl = s3.getSignedUrl('getObject', params);
    var inputData = {
      "inputUrl": signedUrl,
      "outputFile": "data://.algo/sphinx/SpeechRecognition/temp/outputSpeech.json"
    };

    //Additional parameters:
    //Set the timeout to 50mins (to support up to medium length videos
    //Specify output=void which will turn this into a server-side async call
    //  so that the Lambda completes quickly without timing out
    var algoUri = algorithm + "?timeout=3000&output=void";

    // Run the algorithm
    var client = algorithmia(apiKey);
    client.algo(algoUri).pipe(inputData).then(function(output) {
        if(output.error) {
            // The api-server server returned an error
            console.log("Error: " + output.error.message);
            context.fail(output.error.message);
        } else {
            // Return the data uri where the file will end up at
            // - Note that this is an async call - the algorithm will still be processing in the background
            context.succeed(inputData.outputFile);
        }
    });
}
```
