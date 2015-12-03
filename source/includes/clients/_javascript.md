## Javascript Client

[needs documentation]
[needs formatting]

### Downloading the Algorithmia Javascript Client  

You can download our javascript client from:

> [https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js](https://algorithmia.com/v1/clients/js/algorithmia-0.2.0.js)

### Calling an Algorithm

```javascript
<script src="//algorithmia.com/v1/clients/js/algorithmia-0.2.0.js" type="text/javascript"></script>
<script>
var input = 41;
var client = Algorithmia.client("@apiKey");
client.algo("docs/JavaAddOne").pipe(input).then(function(output) {
  if(output.error) return console.error("error: " + output.error);
  console.log(output.result);
});
</script>
```

```json
42
```
