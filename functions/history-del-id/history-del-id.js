const AWS = require("aws-sdk");
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
    
    console.log("Borrar Playlist");
    console.log(event.pathParameters.id);

    await dynamo
    .delete({
      TableName: "playlist-history",
      Key: {
        id: event.pathParameters.id,
        userId: userObj.email
      }
    })
    .promise();
    
    body = {
        statusCode: 200,
        message: `Deleted item ${event.pathParameters.id}`
      }
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
