const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async function(event) {
  
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    console.log("Obtener Historial");
        body = 
          await dynamo.scan({
             TableName: "playlist-history" 
            }).promise();

  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};
