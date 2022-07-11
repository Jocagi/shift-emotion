const AWS = require("aws-sdk");
const { v4: uuidv4 } = require("uuid");
const { getUserFromToken } = require("utils");

const dynamo = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async function(event) {
  
  //const userObj = await getUserFromToken(event.headers.Authorization);

  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    let requestJSON = JSON.parse(event.body);
    let requestId = uuidv4();
    let date_ob = new Date();

    console.log(requestJSON);
    await dynamo
      .put({
        TableName: "playlist-history",
        Item: {
          id: requestId,
          userId: requestJSON.email, 
          createdAt: date_ob.toString(),
          name: requestJSON.name,
          emotion: requestJSON.emotion,
          songs: requestJSON.songs
        }
      })
      .promise();
    body = {
      statusCode: 200,
      message: `Put item ${requestId}`
    };
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
