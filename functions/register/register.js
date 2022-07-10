const { createDbUser } = require("db");

module.exports.handler = async function registerUser(event) {
  
  console.log("Inicia Lamda register_function");
  console.log("body", event.body);
  console.log("headers", event.headers);

  try {
    const body = JSON.parse(event.body);

    return createDbUser(body)
      .then(user => ({
        statusCode: 200,
        body: JSON.stringify({ "message": "OK" })
      }))
      .catch(err => {
        console.log({ err });
  
        return {
          statusCode: err.statusCode || 500,
          headers: { "Content-Type": "text/plain" },
          body: { stack: err.stack, message: err.message }
        };
      });
  }
  catch (err) {
    return {
      statusCode: err.statusCode || 500,
      message: err.message
    }
  }
  
};
