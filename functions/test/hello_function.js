module.exports.handler = async function(event) {
  console.log("Inicia Lamda hello_function");
  return {
    statusCode: 200,
    message: 'Hello World!',
    date: new Date().toISOString()
  };
};
