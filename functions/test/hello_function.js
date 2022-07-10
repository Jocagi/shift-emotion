module.exports.handler = async function(event) {
  console.log("Inicia Lamda hello_function");
  return {
    statusCode: 200,
    body: 'Hello World!'
  };
};
