const AWS = require("aws-sdk");
const { v4: uuidv4 } = require("uuid");
const { getUserFromToken } = require("utils");

const dynamo = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async function(event) {
  
  const userObj = await getUserFromToken(event.headers.Authorization);

  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    console.log("Obtener Historial");
    console.log(userObj);

    body = await dynamo
    .scan({
      TableName: "playlist-history",
      FilterExpression: "#e = :v_Id",
      ExpressionAttributeNames: {
        "#e": "userId",
      },
      ExpressionAttributeValues: {
        ":v_Id": userObj.email
      },
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
